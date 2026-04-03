import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final nameController = TextEditingController(text: "Product Name");
  final priceController = TextEditingController(text: "500");
  final descController = TextEditingController(text: "Product Description");

  InputDecoration fieldDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.green),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 10),

            // Image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.image, size: 50),
            ),

            const SizedBox(height: 25),

            // Name
            TextField(
              controller: nameController,
              decoration: fieldDecoration("Product Name", Icons.shopping_bag),
            ),

            const SizedBox(height: 16),

            // Price
            TextField(
              controller: priceController,
              decoration: fieldDecoration("Price", Icons.currency_rupee),
            ),

            const SizedBox(height: 16),

            // Description
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: fieldDecoration("Description", Icons.description),
            ),

            const SizedBox(height: 30),

            // Update Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Product Updated")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Update Product"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}