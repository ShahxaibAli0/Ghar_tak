import 'package:flutter/material.dart';

class HardwareChatScreen extends StatelessWidget {
  const HardwareChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with Store"),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          "Chat Screen Coming Soon...",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}