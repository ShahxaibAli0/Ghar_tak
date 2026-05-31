import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class ShopPrivacyPolicyScreen extends StatelessWidget {
  const ShopPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 8),
                _buildSection(
                  '1. Information We Collect',
                  'We collect information you provide when registering as a seller, including your shop name, contact details, CNIC, and bank information. We also collect data about your products and transactions.',
                ),
                _buildSection(
                  '2. How We Use Your Information',
                  'Your information is used to manage your seller account, process payments, display your products to buyers, and provide customer support.',
                ),
                _buildSection(
                  '3. Data Security',
                  'We use industry-standard encryption to protect your personal and financial data. Your bank details are stored securely and never shared with third parties.',
                ),
                _buildSection(
                  '4. Product Listings',
                  'Products you publish will be visible to all users of the Ghar Tak platform. You are responsible for ensuring your listings are accurate and comply with our guidelines.',
                ),
                _buildSection(
                  '5. Payment & Transactions',
                  'All transactions are processed securely. Funds are transferred to your registered bank account after order completion.',
                ),
                _buildSection(
                  '6. Your Rights',
                  'You can update or delete your account information at any time. You may request deletion of your data by contacting our support team.',
                ),
                _buildSection(
                  '7. Changes to Policy',
                  'We may update this policy from time to time. You will be notified of any significant changes through the app.',
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: SellerColors.lightGreen,
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Last updated: May 2026',
                    style: TextStyle(
                      color: SellerColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          20, 55, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF007A3D),
            Color(0xFF00A651),
            Color(0xFF2ECC7A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius:
                    BorderRadius.circular(10),
              ),
              child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18),
            ),
          ),
          const SizedBox(width: 14),
          const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text('Privacy Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Read our privacy terms',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String body) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: SellerColors.darkText,
              )),
          const SizedBox(height: 8),
          Text(body,
              style: const TextStyle(
                color: SellerColors.subText,
                fontSize: 12,
                height: 1.6,
              )),
        ],
      ),
    );
  }
}