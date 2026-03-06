import 'package:flutter/material.dart';
import '../../data/dummy_offers.dart';
import 'offer_card.dart';

class OffersScreen extends StatelessWidget {

  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers"),
      ),

      body: ListView.builder(
        itemCount: offers.length,
        itemBuilder: (context, index) {

          return OfferCard(
            offer: offers[index],
          );

        },
      ),

    );

  }

}