import 'package:flutter/material.dart';
import '../data/electric_data.dart';
import 'electrician_services_screen.dart';

class ElectricCategoryScreen extends StatelessWidget {
  const ElectricCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Electric Shops"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: electricShops.length,
        itemBuilder: (context, index) {
          final shop = electricShops[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(
                shop.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ElectricianServicesScreen(shop: shop),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}