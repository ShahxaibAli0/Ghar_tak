import 'package:flutter/material.dart';
import '../../models/offer_model.dart';
import '../providers/provider_profile_screen.dart';

class OfferDetailsScreen extends StatefulWidget {

  final Offer offer;

  const OfferDetailsScreen({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {

  void acceptOffer() {
    setState(() {
      widget.offer.status = "accepted";
    });
  }

  void rejectOffer() {
    setState(() {
      widget.offer.status = "rejected";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Offer Details"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xff1E9E6A),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    widget.offer.providerName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Text(
              "Service: ${widget.offer.serviceName}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(widget.offer.description),

            const SizedBox(height: 20),

            Text(
              "Price: Rs ${widget.offer.price}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Status: ${widget.offer.status}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProviderProfileScreen(
                        offer: widget.offer,
                      ),
                    ),
                  );

                },

                child: const Text("View Provider Profile"),

              ),
            ),

            const SizedBox(height: 25),

            if (widget.offer.status == "pending")

              Row(
                children: [

                  Expanded(
                    child: ElevatedButton(

                      onPressed: acceptOffer,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),

                      child: const Text("Accept"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(

                      onPressed: rejectOffer,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),

                      child: const Text("Reject"),
                    ),
                  ),

                ],
              ),

          ],
        ),
      ),
    );
  }
}