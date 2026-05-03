import 'package:flutter/material.dart';

import '../../services/ai_chat_service.dart';

class HardwareChatScreen extends StatefulWidget {
  const HardwareChatScreen({Key? key}) : super(key: key);

  @override
  State<HardwareChatScreen> createState() => _HardwareChatScreenState();
}

class _HardwareChatScreenState extends State<HardwareChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final AiChatService _aiChatService = AiChatService();
  final List<Map<String, String>> _messages = [];
  bool _isWaitingForAi = false;

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isWaitingForAi) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _isWaitingForAi = true;
      _controller.clear();
    });

    try {
      final reply = await _aiChatService.sendMessage(
        chatType: 'hardware',
        storeName: 'Hardware Store',
        message: text,
        history: _messages
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
        _messages.add({'sender': 'ai', 'text': reply});
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _messages.add({
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
        title: const Text('Chat with Store'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length + (_isWaitingForAi ? 1 : 0),
              itemBuilder: (context, index) {
                final isTyping = index >= _messages.length;
                final message = isTyping
                    ? {'sender': 'ai', 'text': 'AI is typing...'}
                    : _messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['text'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask about hardware items...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _isWaitingForAi ? null : _sendMessage,
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
