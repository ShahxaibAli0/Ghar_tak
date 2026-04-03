import 'package:flutter/material.dart';
import 'package:ghar_tak/vendor_panel/dashboard/dashboard_screen.dart';

class ShopInfoScreen extends StatefulWidget {
  const ShopInfoScreen({super.key});

  @override
  State<ShopInfoScreen> createState() => _ShopInfoScreenState();
}

class _ShopInfoScreenState extends State<ShopInfoScreen> {

  final shopController = TextEditingController();
  final addressController = TextEditingController();

  String selectedCategory = "Grocery";

  final categories = [
    "Grocery",
    "Pharmacy",
    "Restaurant",
    "Electric Store",
    "Hardware",
    "Plumber",
    "Electrician",
    "IT Technician",
    "Carpenter",
  ];

  InputDecoration fieldDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.green),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Setup")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: shopController,
              decoration: fieldDecoration("Shop Name", Icons.store),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: addressController,
              decoration: fieldDecoration("Address", Icons.location_on),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField(
              value: selectedCategory,
              items: categories
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: fieldDecoration("Category", Icons.category),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {

                  // Optional validation (simple)
                  if (shopController.text.isEmpty ||
                      addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill all fields")),
                    );
                    return;
                  }

                  // ✅ NAVIGATION FIX
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VendorDashboardScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Finish Setup"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}