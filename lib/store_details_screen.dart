import 'package:flutter/material.dart';

class StoreDetailsScreen extends StatefulWidget {
  final String storeName;
  final List<Map<String, dynamic>> products;

  const StoreDetailsScreen({super.key, required this.storeName, required this.products});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  final Map<String, int> cart = {}; // productName -> quantity

  void _addToCart(String productName) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Quantity"),
        content: StatefulBuilder(
          builder: (context, setStateDialog) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      setStateDialog(() {
                        quantity--;
                      });
                    }
                  },
                ),
                Text(quantity.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setStateDialog(() {
                      quantity++;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                cart[productName] = quantity;
              });
              Navigator.pop(context);
            },
            child: const Text("Add to Cart"),
          ),
        ],
      ),
    );
  }

  double get totalPrice {
    double total = 0;
    for (var product in widget.products) {
      if (cart.containsKey(product['name'])) {
        total += product['price'] * cart[product['name']]!;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "Cart: ${cart.length} | Rs ${totalPrice.toStringAsFixed(0)}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Image.network(product['image'], height: 80, width: 80),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber.shade600, size: 16),
                          const SizedBox(width: 4),
                          Text(product['rating'].toString()),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text("Price: Rs ${product['price']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (product['discount'] != 0)
                        Text("${product['discount']}% Off", style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _addToCart(product['name']),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Add to Cart"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}