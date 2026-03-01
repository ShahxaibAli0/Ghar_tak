import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final Map<String, int> cart; // productName -> quantity
  final List<Map<String, dynamic>> products;

  const CartScreen({super.key, required this.cart, required this.products});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double deliveryCharge = 100;

  double get subtotal {
    double total = 0;
    for (var product in widget.products) {
      if (widget.cart.containsKey(product['name'])) {
        total += product['price'] * widget.cart[product['name']]!;
      }
    }
    return total;
  }

  double get total => subtotal + deliveryCharge;

  @override
  Widget build(BuildContext context) {
    final cartItems = widget.products.where((p) => widget.cart.containsKey(p['name'])).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      backgroundColor: Colors.grey[100],
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...cartItems.map((product) {
                  int qty = widget.cart[product['name']]!;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${product['name']} x$qty", style: const TextStyle(fontSize: 16)),
                        Text("Rs ${product['price'] * qty}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                }).toList(),

                const SizedBox(height: 10),
                Divider(color: Colors.grey.shade400),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal", style: TextStyle(fontSize: 16)),
                      Text("Rs ${subtotal.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Charges", style: TextStyle(fontSize: 16)),
                      Text("Rs ${deliveryCharge.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                ),

                Divider(color: Colors.grey.shade400),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Rs ${total.toStringAsFixed(0)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(cart: widget.cart, products: widget.products),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Proceed to Checkout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
    );
  }
}