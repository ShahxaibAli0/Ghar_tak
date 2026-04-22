import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/offer_model.dart';
import '../../providers/offer_provider.dart';
import 'offer_details_screen.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  // ── helpers ──────────────────────────────────────────────

  Color _borderColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  Color _badgeColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  String _badgeLabel(String status) {
    switch (status) {
      case 'accepted':
        return 'Accepted';
      default:
        return 'Pending';
    }
  }

  // ── dialogs ──────────────────────────────────────────────

  void _confirmAccept(BuildContext context, OfferProvider provider, int index) {
    final offer = provider.offers[index];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Accept Offer"),
        content: Text(
          "Accept the offer from ${offer.providerName}?\n\nAll other pending offers will be invalidated.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              provider.acceptOffer(index);
              _showSuccessDialog(context, offer);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Accept"),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, Offer offer) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: Colors.green, size: 56),
            ),
            const SizedBox(height: 16),
            const Text(
              "Offer Accepted Successfully!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "${offer.providerName} will contact you shortly.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Great!", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmReject(BuildContext context, OfferProvider provider, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Reject Offer"),
        content: const Text("Are you sure you want to reject this offer?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              provider.rejectOffer(index);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Reject"),
          ),
        ],
      ),
    );
  }

  // ── build ─────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferProvider>(
      builder: (context, provider, _) {
        final allOffers = provider.offers;

        // Only show pending and accepted — remove rejected & invalidated
        final visible = [
          for (int i = 0; i < allOffers.length; i++)
            if (allOffers[i].status != 'rejected' &&
                allOffers[i].status != 'invalidated')
              MapEntry(i, allOffers[i]),
        ];

        if (visible.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text("Offers"), backgroundColor: Colors.green),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 72, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("No active offers", style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Offers (${visible.length})"),
            backgroundColor: Colors.green,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: visible.length,
            itemBuilder: (context, idx) {
              final index = visible[idx].key;
              final offer = visible[idx].value;

              return GestureDetector(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OfferDetailsScreen(
                            offer: offer,
                            offerIndex: index,
                          ),
                        ),
                      ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: _borderColor(offer.status),
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Header row ──
                          Row(
                            children: [
                              const Icon(Icons.home_repair_service,
                                  color: Color(0xff1E9E6A)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  offer.providerName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // ── Status badge ──
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _badgeColor(offer.status)
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: _badgeColor(offer.status),
                                      width: 1),
                                ),
                                child: Text(
                                  _badgeLabel(offer.status),
                                  style: TextStyle(
                                    color: _badgeColor(offer.status),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),
                          Text(offer.serviceName,
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(offer.description,
                              style: const TextStyle(color: Colors.black87)),
                          const SizedBox(height: 8),

                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.orange, size: 16),
                              const SizedBox(width: 4),
                              Text("${offer.rating}"),
                              const SizedBox(width: 12),
                              const Icon(Icons.work_outline,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text("${offer.completedjobs} jobs"),
                              const Spacer(),
                              Text(
                                "Rs ${offer.price}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),

                          // ── Action buttons (pending only) ──
                          if (offer.status == "pending") ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _confirmAccept(context, provider, index),
                                    icon: const Icon(Icons.check, size: 18),
                                    label: const Text("Accept"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _confirmReject(context, provider, index),
                                    icon: const Icon(Icons.close, size: 18),
                                    label: const Text("Reject"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],

                          // ── Accepted banner ──
                          if (offer.status == "accepted") ...[
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle,
                                      color: Colors.green, size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    "You accepted this offer",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],

                        ],
                      ),
                    ),
                  ),
                );
            },
          ),
        );
      },
    );
  }
}
