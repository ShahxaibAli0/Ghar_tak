import 'package:flutter/material.dart';

import '../../data/dummy_offers_data.dart';
import '../../models/offer_model.dart';
import 'offer_details_screen.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {

  void acceptOffer(int index) {
    setState(() {
      dummyOffers[index].status = "accepted";
    });
  }

  void rejectOffer(int index) {
    setState(() {
      dummyOffers[index].status = "rejected";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Offers"),
      ),

      body: dummyOffers.isEmpty
          ? const Center(
              child: Text("No requests yet"),
            )

          : ListView.builder(

              itemCount: dummyOffers.length,

              itemBuilder: (context, index) {

                Offer offer = dummyOffers[index];

                return GestureDetector(

                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OfferDetailsScreen(
                          offer: offer,
                        ),
                      ),
                    );

                  },

                  child: Card(

                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),

                    elevation: 3,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Padding(

                      padding: const EdgeInsets.all(14),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [

                              const Icon(
                                Icons.home_repair_service,
                                color: Color(0xff1E9E6A),
                              ),

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

                            ],
                          ),

                          const SizedBox(height: 6),

                          Text(
                            offer.serviceName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            offer.description,
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Price: Rs ${offer.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Status: ${offer.status}",
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 10),

                          if (offer.status == "pending")

                            Row(
                              children: [

                                Expanded(
                                  child: ElevatedButton(

                                    onPressed: () {
                                      acceptOffer(index);
                                    },

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.green,
                                    ),

                                    child:
                                        const Text("Accept"),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: ElevatedButton(

                                    onPressed: () {
                                      rejectOffer(index);
                                    },

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.red,
                                    ),

                                    child:
                                        const Text("Reject"),
                                  ),
                                ),

                              ],
                            ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}