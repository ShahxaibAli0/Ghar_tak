import 'package:flutter/material.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Products"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddProductScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // dummy data
        itemBuilder: (context, index) {
          return _productCard(context);
        },
      ),
    );
  }

  Widget _productCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.image, size: 30),
          ),

          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Product Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text("Rs. 500", style: TextStyle(color: Colors.green)),
              ],
            ),
          ),

          // Actions
          Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProductScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.blue),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}