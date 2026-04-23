import 'package:flutter/material.dart';
import 'store_products_screen.dart';
// ignore: unused_import
import '../../data/grocery_data.dart';
import '../../widgets/seller_products_section.dart';

class GroceryCategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> stores;
  const GroceryCategoryScreen({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Grocery Stores"),
          backgroundColor: Colors.green),
      body: CustomScrollView(
        slivers: [
          // ── Seller-added grocery products ──
          const SliverToBoxAdapter(
            child: SellerProductsSection(category: 'Grocery'),
          ),
          // ── Stores list ──
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final store = stores[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StoreProductsScreen(store: store),
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(store["logo"])),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(store["name"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "Delivery: Rs ${store["delivery"]}"),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.orange, size: 16),
                                      const SizedBox(width: 4),
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
                childCount: stores.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
