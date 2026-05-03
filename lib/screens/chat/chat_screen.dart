import 'package:flutter/material.dart';

import '../../models/offer_model.dart';
import '../../services/ai_chat_service.dart';

class ChatScreen extends StatefulWidget {
  final Offer offer;

  const ChatScreen({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final AiChatService _aiChatService = AiChatService();

  final List<Map<String, String>> messages = [];
  bool _isWaitingForAi = false;

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty || _isWaitingForAi) return;

    setState(() {
      messages.add({
        'sender': 'user',
        'text': text,
      });
      _isWaitingForAi = true;
      messageController.clear();
    });

    try {
      final reply = await _aiChatService.sendMessage(
        chatType: 'provider',
        storeName: widget.offer.providerName,
        message: text,
        history: messages
            .where((message) => message['text']?.isNotEmpty ?? false)
            .map(
              (message) => AiChatMessage(
                role: message['sender'] == 'ai' ? 'assistant' : 'user',
                content: message['text'] ?? '',
              ),
            )
            .toList(),
      );

      if (!mounted) return;
      setState(() {
        messages.add({
          'sender': 'ai',
          'text': reply,
        });
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        messages.add({
          'sender': 'ai',
          'text': 'Sorry, AI reply nahi aa saki. Backend check karen.',
        });
      });
    } finally {
      if (mounted) {
        setState(() => _isWaitingForAi = false);
      }
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offer.providerName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length + (_isWaitingForAi ? 1 : 0),
              itemBuilder: (context, index) {
                final isTyping = index >= messages.length;
                final isUser =
                    !isTyping && messages[index]['sender'] == 'user';

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isTyping
                          ? 'AI is typing...'
                          : messages[index]['text'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _isWaitingForAi ? null : sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
