import 'package:flutter/material.dart';
import '../../models/offer_model.dart';
import 'view_bid_screen.dart';

class OfferCard extends StatelessWidget {

  final Offer offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              offer.providerName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text("Category: ${offer.category}"),

            const SizedBox(height: 5),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 18),
                Text("${offer.rating}"),
                const SizedBox(width: 10),
                Text("${offer.completedjobs} Jobs"),
              ],
            ),

            const SizedBox(height: 10),

            Text("Offer Price: \$${offer.price}"),

            const SizedBox(height: 10),

            Row(
              children: [

                ElevatedButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewBidScreen(offer: offer),
                      ),
                    );

                  },
                  child: const Text("View Bid"),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Accept"),
                ),

              ],
            )

          ],
        ),
      ),
    );

  }

}