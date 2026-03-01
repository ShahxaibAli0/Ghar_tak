import 'package:flutter/material.dart';
import '../data/restaurants_data.dart';
import '../screens/restaurant_products_screen.dart';

class RestaurantsCategoryScreen extends StatelessWidget {
  const RestaurantsCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: restaurantsList.length,
        itemBuilder: (context, index) {
          final restaurant = restaurantsList[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(
                restaurant.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RestaurantProductsScreen(restaurant: restaurant),
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