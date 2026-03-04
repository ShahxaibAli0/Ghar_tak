import 'package:flutter/material.dart';
import 'store_products_screen.dart';
// ignore: unused_import
import '../../data/grocery_data.dart';

class GroceryCategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> stores;
  GroceryCategoryScreen({required this.stores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery Stores"), backgroundColor: Colors.green),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: stores.length,
        itemBuilder: (context, index) {
          var store = stores[index];
          return GestureDetector(
            onTap: () {
              // ✅ Navigate to store products
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreProductsScreen(store: store),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(radius: 30, backgroundImage: NetworkImage(store["logo"])),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(store["name"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("Delivery: Rs ${store["delivery"]}"),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              SizedBox(width: 4),
                              Text("${store["rating"]}")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}