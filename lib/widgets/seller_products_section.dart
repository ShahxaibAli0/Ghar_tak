import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class SellerProductsSection extends StatelessWidget {
  final String category;
  const SellerProductsSection({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        final products = provider.byCategory(category);
        if (products.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Row(
                children: [
                  const Icon(Icons.storefront, color: Colors.green, size: 18),
                  const SizedBox(width: 6),
                  const Text(
                    "New Arrivals",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Text(
                      "${products.length} items",
                      style: const TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) =>
                  _SellerProductCard(product: products[index]),
            ),
            const Divider(height: 24),
          ],
        );
      },
    );
  }
}

class _SellerProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const _SellerProductCard({required this.product});

  int get _parsedPrice {
    final raw = (product['price'] as String? ?? '')
        .replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(raw) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = product['imagePath'] as String?;
    final hasFile = imagePath != null &&
        imagePath.isNotEmpty &&
        File(imagePath).existsSync();
    final icon = product['image'] as IconData? ?? Icons.shopping_bag_outlined;
    final color = product['color'] as Color? ?? Colors.grey;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasFile
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(imagePath),
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _iconFallback(color, icon),
                    ),
                  )
                : _iconFallback(color, icon),
            const SizedBox(height: 5),
            Text(
              product['name'] as String? ?? '',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              product['price'] as String? ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                context.read<CartProvider>().addItem(CartItem(
                      name: product['name'] as String? ?? '',
                      price: _parsedPrice,
                      image: imagePath ?? '',
                      storeName: 'Seller Store',
                    ));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${product['name']} added to cart"),
                    duration: const Duration(seconds: 1),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 30),
                backgroundColor: Colors.green,
              ),
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconFallback(Color color, IconData icon) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.grey, size: 36),
    );
  }
}
