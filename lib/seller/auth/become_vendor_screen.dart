import 'package:flutter/material.dart';

import 'seller_auth_store.dart';
import 'seller_login_screen.dart';
import 'seller_register_screen.dart';

class BecomeVendorScreen extends StatelessWidget {
  const BecomeVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<bool>(
        future: SellerAuthStore.hasAccount(),
        builder: (context, snapshot) {
          final hasAccount = snapshot.data ?? false;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Start Selling Today",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  hasAccount
                      ? "Your seller account is already set up. Login to continue."
                      : "Join us as a vendor and grow your business",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => hasAccount
                              ? const SellerLoginScreen()
                              : const SellerRegisterScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      hasAccount ? "Seller Login" : "Become a Seller",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => hasAccount
                            ? const SellerRegisterScreen()
                            : const SellerLoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    hasAccount
                        ? "Need another seller account? Sign Up"
                        : "Already have a seller account? Login",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
