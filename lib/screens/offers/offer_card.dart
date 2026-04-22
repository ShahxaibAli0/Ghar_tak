import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/offer_model.dart';
import '../../providers/offer_provider.dart';
import 'view_bid_screen.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  final int offerIndex;

  const OfferCard({super.key, required this.offer, required this.offerIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferProvider>(
      builder: (context, provider, _) {
        final current = provider.offers[offerIndex];

        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  current.providerName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text("Category: ${current.category}"),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 18),
                    Text("${current.rating}"),
                    const SizedBox(width: 10),
                    Text("${current.completedjobs} Jobs"),
                  ],
                ),
                const SizedBox(height: 10),
                Text("Offer Price: Rs ${current.price}"),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViewBidScreen(
                            offer: current,
                            offerIndex: offerIndex,
                          ),
                        ),
                      ),
                      child: const Text("View Bid"),
                    ),
                    const SizedBox(width: 10),
                    if (current.status == "pending")
                      ElevatedButton(
                        onPressed: () {
                          provider.acceptOffer(offerIndex);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("Accept"),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
