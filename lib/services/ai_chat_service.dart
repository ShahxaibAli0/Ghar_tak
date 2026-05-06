import 'dart:convert';

import 'package:http/http.dart' as http;

class AiChatMessage {
  final String role;
  final String content;

  const AiChatMessage({
    required this.role,
    required this.content,
  });

  Map<String, String> toJson() => {
        'role': role,
        'content': content,
      };
}

class AiChatService {
  static const String _baseUrl = String.fromEnvironment(
    'AI_BACKEND_URL',
    defaultValue: 'https://ghartak-production-1aa5.up.railway.app',
  );

  Future<String> sendMessage({
    required String chatType,
    required String message,
    String? storeName,
    List<AiChatMessage> history = const [],
  }) async {
    final uri = Uri.parse('$_baseUrl/ai/chat');
    final outgoingMessages = [
      ...history.map((item) => item.toJson()),
    ];

    if (outgoingMessages.isEmpty ||
        outgoingMessages.last['content'] != message) {
      outgoingMessages.add({'role': 'user', 'content': message});
    }

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'chatType': chatType,
        'storeName': storeName,
        'message': message,
        'messages': outgoingMessages,
      }),
    );

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(decoded['error'] ?? 'AI chat request failed.');
    }

    final reply = decoded['reply']?.toString().trim() ?? '';
    if (reply.isEmpty) {
      throw Exception('AI returned an empty reply.');
    }

    return reply;
  }
}
