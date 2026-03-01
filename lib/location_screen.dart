import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? selectedCity;
  String? selectedColony;

  Map<String, List<String>> cities = {
    "Lahore": ["DHA", "Johar Town", "Gulberg", "Iqbal Town"],
    "Karachi": ["Clifton", "Defence", "Korangi", "PECHS"],
    "Islamabad": ["F-6", "F-7", "G-9", "G-10"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // 🔹 City Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select City",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: selectedCity,
              items: cities.keys
                  .map((city) => DropdownMenuItem(
                        child: Text(city),
                        value: city,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedCity = val;
                  selectedColony = null; // reset colony
                });
              },
            ),

            SizedBox(height: 20),

            // 🔹 Colony Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Colony",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: selectedColony,
              items: selectedCity == null
                  ? []
                  : cities[selectedCity!]!
                      .map((colony) => DropdownMenuItem(
                            child: Text(colony),
                            value: colony,
                          ))
                      .toList(),
              onChanged: (val) {
                setState(() {
                  selectedColony = val;
                });
              },
            ),

            SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: selectedCity != null && selectedColony != null
                  ? () {
                      Navigator.pop(context, {
                        "city": selectedCity,
                        "colony": selectedColony
                      });
                    }
                  : null,
              child: Text("Confirm Location"),
            ),
          ],
        ),
      ),
    );
  }
}