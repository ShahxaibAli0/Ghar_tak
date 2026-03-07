import 'package:flutter/material.dart';
import '../../models/offer_model.dart';
import '../chat/chat_screen.dart';

class ProviderProfileScreen extends StatelessWidget {

  final Offer offer;

  const ProviderProfileScreen({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Provider Profile"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xff1E9E6A),
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              offer.providerName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              offer.serviceName,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [

                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star_half, color: Colors.orange),

              ],
            ),

            const SizedBox(height: 20),

            Text(
              offer.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 30),

            const Text(
              "Service Price",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Rs ${offer.price}",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(

                    onPressed: () {
                      // Call functionality future me add ho sakti hai
                    },

                    icon: const Icon(Icons.call),

                    label: const Text("Call"),

                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(

                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            offer: offer,
                          ),
                        ),
                      );

                    },

                    icon: const Icon(Icons.chat),

                    label: const Text("Chat"),

                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}