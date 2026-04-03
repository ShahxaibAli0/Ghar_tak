import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

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
        title: const Text("Add Product"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            const Text(
              "Add New Product",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Fill details to list your product",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // Image Upload (UI only)
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                    SizedBox(height: 8),
                    Text("Upload Product Image"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Product Name
            TextField(
              controller: nameController,
              decoration: fieldDecoration("Product Name", Icons.shopping_bag),
            ),

            const SizedBox(height: 16),

            // Price
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
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

            // Add Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Product Added (UI Only)")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  "Add Product",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}