import 'package:flutter/material.dart';
import '../../data/dummy_offers_data.dart';
import '../../models/offer_model.dart';

class ServiceHistoryScreen extends StatelessWidget {

  const ServiceHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Offer> historyOffers = dummyOffers
        .where((offer) => offer.status != "pending")
        .toList();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Service History"),
      ),

      body: historyOffers.isEmpty
          ? const Center(
              child: Text("No completed services yet"),
            )
          : ListView.builder(

              itemCount: historyOffers.length,

              itemBuilder: (context, index) {

                Offer offer = historyOffers[index];

                return Card(

                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),

                  child: ListTile(

                    leading: const CircleAvatar(
                      backgroundColor: Color(0xff1E9E6A),
                      child: Icon(
                        Icons.home_repair_service,
                        color: Colors.white,
                      ),
                    ),

                    title: Text(offer.providerName),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(offer.serviceName),

                        Text(
                          "Price: Rs ${offer.price}",
                          style: const TextStyle(
                            color: Colors.green,
                          ),
                        ),

                        Text(
                          "Status: ${offer.status}",
                          style: const TextStyle(
                            color: Colors.orange,
                          ),
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