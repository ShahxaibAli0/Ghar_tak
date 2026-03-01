import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productName;
  final double price;

  const ProductDetailsScreen({
    Key? key,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(productName),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔹 Product Image Section
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.green[200],
              child: const Center(
                child: Icon(
                  Icons.home_repair_service,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 🔹 Title
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔹 Price
                  Text(
                    "Rs ${price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "This is a professional $productName service provided by Ghar Tak. "
                    "Fast, reliable and trusted service at your doorstep.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 🔹 Add To Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .addItem(productName, price);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to cart successfully"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}