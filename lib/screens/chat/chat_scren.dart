import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController messageController = TextEditingController();

  final List<String> messages = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Chat"),
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {

                return ListTile(
                  title: Text(messages[index]),
                );

              },
            ),
          ),

          Row(
            children: [

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Type message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),

              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {

                  setState(() {

                    messages.add(messageController.text);
                    messageController.clear();

                  });

                },
              )

            ],
          )

        ],
      ),

    );

  }

}