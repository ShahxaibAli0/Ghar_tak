import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrdersScreen({super.key, required this.orders});

  Color getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      backgroundColor: Colors.grey[100],
      body: orders.isEmpty
          ? const Center(child: Text("No orders yet!"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Order ${order['id']} details clicked!")),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order #${order['id']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: getStatusColor(order['status']),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(order['status'], style: const TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...order['products'].map<Widget>((p) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${p['name']} x${p['quantity']}"),
                                Text("Rs ${p['price'] * p['quantity']}"),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 8),
                        Divider(color: Colors.grey.shade400),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Rs ${order['total']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}