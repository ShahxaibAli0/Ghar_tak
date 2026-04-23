import 'package:flutter/material.dart';

import '../../screens/auth/login_screen.dart';
import '../../shared/app_entry_preference.dart';
import '../widgets/seller_colors.dart';
import 'seller_login_screen.dart';
import 'seller_register_screen.dart';

class SellerAuthEntryScreen extends StatelessWidget {
  final bool showBackButton;

  const SellerAuthEntryScreen({
    super.key,
    this.showBackButton = true,
  });

  Future<void> _openSignIn(BuildContext context) async {
    await AppEntryPreference.setSellerMode();
    if (!context.mounted) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SellerLoginScreen()),
    );
  }

  Future<void> _openSignUp(BuildContext context) async {
    await AppEntryPreference.setSellerMode();
    if (!context.mounted) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SellerRegisterScreen()),
    );
  }

  Future<void> _switchToBuyerAccount(BuildContext context) async {
    await AppEntryPreference.setBuyerMode();
    if (!context.mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: showBackButton && Navigator.canPop(context)
          ? AppBar(
              backgroundColor: Colors.white,
              foregroundColor: SellerColors.primary,
              elevation: 0,
              title: const Text(
                'Seller Center',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            )
          : null,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: SellerColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.storefront,
                    color: SellerColors.primary,
                    size: 46,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Seller Center',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: SellerColors.darkText,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose how you want to continue with your seller account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: SellerColors.subText,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SellerColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => _openSignIn(context),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: SellerColors.primary,
                        width: 1.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => _openSignUp(context),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: SellerColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _switchToBuyerAccount(context),
                  child: const Text(
                    'Switch to Buyer Account',
                    style: TextStyle(
                      color: SellerColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
