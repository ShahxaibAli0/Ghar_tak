import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../data/restaurants_data.dart';
import '../../screens/cart/cart_screen.dart';

class RestaurantProductsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantProductsScreen({Key? key, required this.restaurant})
      : super(key: key);

  static const List<int> _prices = [
    250, 350, 300, 200, 180, 220, 150, 280, 160, 100,
  ];

  int _priceFor(int index) => _prices[index % _prices.length];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        centerTitle: true,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, _) => Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
                ),
                if (cart.itemCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${cart.itemCount}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: restaurant.products.length,
        itemBuilder: (context, index) {
          final name = restaurant.products[index];
          final price = _priceFor(index);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.fastfood, color: Colors.green),
              ),
              title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text("Rs $price"),
              trailing: ElevatedButton(
                onPressed: () {
                  context.read<CartProvider>().addItem(CartItem(
                    name: name,
                    price: price,
                    image: "https://via.placeholder.com/100",
                    storeName: restaurant.name,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$name added to cart"),
                      duration: const Duration(seconds: 1),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(60, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Add"),
              ),
            ),
          );
        },
      ),
    );
  }
}
