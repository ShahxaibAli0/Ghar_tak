import 'package:flutter/material.dart';
import '../../models/provider_model.dart';

class ProviderProfileScreen extends StatelessWidget {

  final ProviderModel provider;

  const ProviderProfileScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider Profile"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              provider.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("Category: ${provider.category}"),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange),
                Text("${provider.rating}"),
                const SizedBox(width: 10),
                Text("${provider.completedJobs} Jobs"),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "About",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Text(provider.description),

          ],
        ),
      ),
    );

  }

}