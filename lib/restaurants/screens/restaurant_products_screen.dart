import 'package:flutter/material.dart';
import '../data/restaurants_data.dart';

class RestaurantProductsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantProductsScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: restaurant.products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(restaurant.products[index]),
              trailing: const Icon(Icons.fastfood),
            ),
          );
        },
      ),
    );
  }
}