import 'package:flutter/material.dart';
import '../models/provider_model.dart';
import '../screens/provider/provider_profile_screen.dart';

class ProviderCard extends StatelessWidget {

  final ProviderModel provider;

  const ProviderCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(10),

      child: ListTile(

        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),

        title: Text(provider.name),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(provider.category),

            Row(
              children: [

                const Icon(Icons.star, size: 16, color: Colors.orange),

                Text("${provider.rating}"),

                const SizedBox(width: 8),

                Text("${provider.completedJobs} jobs"),

              ],
            )

          ],
        ),

        trailing: const Icon(Icons.arrow_forward),

        onTap: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProviderProfileScreen(provider: provider),
            ),
          );

        },

      ),

    );

  }

}