import 'package:flutter/material.dart';
import '../../data/pharmacy_data.dart';
import 'pharmacy_chat_screen.dart';

class PharmacyCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pharmacies"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: pharmacyStores.length,
        itemBuilder: (context, index) {
          var store = pharmacyStores[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PharmacyChatScreen(storeName: store["name"]),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(store["logo"]),
                ),
                title: Text(store["name"]),
                subtitle: Text("Delivery: Rs ${store["delivery"]}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text("${store["rating"]}")
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