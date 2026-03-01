import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, int> cart; // productName -> quantity
  final List<Map<String, dynamic>> products; // product details

  const CheckoutScreen({super.key, required this.cart, required this.products});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double deliveryCharge = 100; // fixed for example
  String selectedPayment = "JazzCash";

  double get subtotal {
    double total = 0;
    for (var product in widget.products) {
      if (widget.cart.containsKey(product['name'])) {
        total += product['price'] * widget.cart[product['name']]!;
      }
    }
    return total;
  }

  double get total {
    return subtotal + deliveryCharge;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text("Order Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // Products List
          ...widget.products.where((p) => widget.cart.containsKey(p['name'])).map((product) {
            int qty = widget.cart[product['name']]!;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1)],
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

          // Subtotal
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

          // Delivery Charges
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

          // Total
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

          // Payment Options
          const Text("Select Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Column(
            children: ["JazzCash", "EasyPaisa", "Bank"].map((method) {
              return RadioListTile<String>(
                value: method,
                groupValue: selectedPayment,
                onChanged: (value) {
                  setState(() {
                    selectedPayment = value!;
                  });
                },
                title: Text(method),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Place Order Button
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Order Placed Successfully!")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Place Order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}