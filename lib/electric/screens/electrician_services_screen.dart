import 'package:flutter/material.dart';
import '../data/electric_data.dart';

class ElectricianServicesScreen extends StatelessWidget {
  final ElectricShop shop;

  const ElectricianServicesScreen({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: shop.services.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.electrical_services),
              title: Text(shop.services[index]),
            ),
          );
        },
      ),
    );
  }
}