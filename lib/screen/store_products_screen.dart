import 'package:flutter/material.dart';

class StoreProductsScreen extends StatelessWidget {
  final Map<String, dynamic> store;
  StoreProductsScreen({required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(store["name"]), backgroundColor: Colors.green),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: store["products"].length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            var product = store["products"][index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(product["image"], height: 70, width: 70),
                    SizedBox(height: 5),
                    Text(product["name"], textAlign: TextAlign.center),
                    SizedBox(height: 5),
                    Text("Rs ${product["price"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Add"),
                      style: ElevatedButton.styleFrom(minimumSize: Size(100, 30), backgroundColor: Colors.green),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}