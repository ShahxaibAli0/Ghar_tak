import 'package:flutter/material.dart';
import '../../models/offer_model.dart';

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

  List<Map<String, String>> messages = [];

  void sendMessage() {

    if (messageController.text.trim().isEmpty) return;

    setState(() {

      messages.add({
        "sender": "user",
        "text": messageController.text,
      });

      messageController.clear();

    });

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

              itemCount: messages.length,

              itemBuilder: (context, index) {

                bool isUser =
                    messages[index]["sender"] == "user";

                return Align(

                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(

                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),

                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(

                      color: isUser
                          ? Colors.green
                          : Colors.grey[300],

                      borderRadius:
                          BorderRadius.circular(10),

                    ),

                    child: Text(
                      messages[index]["text"] ?? "",
                      style: TextStyle(
                        color: isUser
                            ? Colors.white
                            : Colors.black,
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
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),

                  ),
                ),

                const SizedBox(width: 10),

                IconButton(

                  onPressed: sendMessage,

                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                  ),

                )

              ],
            ),
          )

        ],
      ),
    );
  }
}