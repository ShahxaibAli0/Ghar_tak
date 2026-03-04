import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'service_request_screen.dart';

class LocationPermissionScreen extends StatefulWidget {
  final String serviceName;

  const LocationPermissionScreen({
    Key? key,
    required this.serviceName,
  }) : super(key: key);

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState
    extends State<LocationPermissionScreen> {

  Future<void> _handleLocationPermission() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enable location services"),
        ),
      );
      return;
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Location permission is required"),
        ),
      );
      return;
    }

    // ✅ Permission Granted → Move to Service Screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceRequestScreen(
          serviceName: widget.serviceName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.location_on,
              size: 100,
              color: Colors.green,
            ),

            const SizedBox(height: 30),

            const Text(
              "Allow Location Access",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "We need your location to connect you with nearby service providers.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _handleLocationPermission,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text("Allow Location"),
              ),
            )
          ],
        ),
      ),
    );
  }
}