import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  final String serviceName;

  const ServicesScreen({super.key, required this.serviceName});

  final List<Map<String, dynamic>> providers = const [
    {"name": "Ali Plumber", "rating": 4.5, "fee": 500, "delivery": "Home Visit"},
    {"name": "Ahmed Electrician", "rating": 4.2, "fee": 600, "delivery": "Home Visit"},
    {"name": "Usman Carpenter", "rating": 4.7, "fee": 700, "delivery": "Home Visit"},
  ];

  @override
  Widget build(BuildContext context) {
    // Filter providers by serviceName if needed (future)
    return Scaffold(
      appBar: AppBar(title: Text(serviceName)),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
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
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(provider['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber.shade600, size: 16),
                        const SizedBox(width: 4),
                        Text(provider['rating'].toString()),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Fee: Rs ${provider['fee']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(provider['delivery'], style: const TextStyle(color: Colors.green)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}