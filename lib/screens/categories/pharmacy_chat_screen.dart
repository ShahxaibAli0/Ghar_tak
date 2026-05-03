import 'package:flutter/material.dart';

import '../../services/ai_chat_service.dart';

class PharmacyChatScreen extends StatefulWidget {
  final String storeName;

  const PharmacyChatScreen({super.key, required this.storeName});

  @override
  State<PharmacyChatScreen> createState() => _PharmacyChatScreenState();
}

class _PharmacyChatScreenState extends State<PharmacyChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final AiChatService _aiChatService = AiChatService();
  final List<Map<String, String>> messages = [];
  bool _isWaitingForAi = false;

  Future<void> sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isWaitingForAi) return;

    setState(() {
      messages.add({'sender': 'user', 'text': text});
      _isWaitingForAi = true;
      _controller.clear();
    });

    try {
      final reply = await _aiChatService.sendMessage(
        chatType: 'pharmacy',
        storeName: widget.storeName,
        message: text,
        history: messages
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
        messages.add({'sender': 'ai', 'text': reply});
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeName),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length + (_isWaitingForAi ? 1 : 0),
              itemBuilder: (context, index) {
                final isTyping = index >= messages.length;
                final message = isTyping
                    ? {'sender': 'ai', 'text': 'AI is typing...'}
                    : messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(message['text'] ?? ''),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _isWaitingForAi ? null : sendMessage,
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
