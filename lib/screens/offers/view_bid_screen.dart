import 'package:flutter/material.dart';
import '../../models/offer_model.dart';

class ViewBidScreen extends StatelessWidget {

  final Offer offer;

  const ViewBidScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider Bid"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              offer.providerName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("Category: ${offer.category}"),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange),
                Text("${offer.rating}"),
                const SizedBox(width: 10),
                Text("${offer.completedjobs} Jobs Completed"),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Text(offer.description),

            const SizedBox(height: 20),

            Text(
              "Bid Price: \$${offer.price}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Chat Provider"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Accept Offer"),
            )

          ],
        ),
      ),
    );

  }

}