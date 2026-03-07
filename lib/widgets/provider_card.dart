import 'package:flutter/material.dart';
import '../models/provider_model.dart';
import '../screens/providers/provider_profile_screen.dart';

class Offer {
  final String title;
  final String providerName;

  Offer({
    required this.title,
    required this.providerName,
  });
}


class ProviderProfileScreen extends StatelessWidget {
  final Offer offer;

  const ProviderProfileScreen({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.title),
      ),
      body: Center(
        child: Text(
          "Provider Name: ${offer.providerName}",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class ProviderCard extends StatelessWidget {
  final Offer offer;

  const ProviderCard({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(offer.title),
        subtitle: Text(offer.providerName),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProviderProfileScreen(
                offer: offer,
              ),
            ),
          );
        },
      ),
    );
  }
}