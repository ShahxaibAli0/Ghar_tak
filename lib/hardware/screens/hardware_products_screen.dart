import 'package:flutter/material.dart';
import '../data/hardware_data.dart';
import 'hardware_chat_screen.dart';

class HardwareProductsScreen extends StatelessWidget {
  final List<HardwareProduct> products;

  const HardwareProductsScreen({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hardware Products"),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(product.image, height: 80),
                const SizedBox(height: 10),
                Text(product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(product.price),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HardwareChatScreen(),
                      ),
                    );
                  },
                  child: const Text("Chat"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}