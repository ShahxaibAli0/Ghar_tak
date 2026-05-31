import 'package:flutter/material.dart';

import '../widgets/seller_colors.dart';


class ShopAboutAppScreen extends StatelessWidget {
  const ShopAboutAppScreen({super.key});

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

                // Logo Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF007A3D),
                        Color(0xFF00A651),
                        Color(0xFF2ECC7A),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.store,
                          color: Color(0xFF00A651),
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text('GHAR TAK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                          )),
                      const SizedBox(height: 4),
                      Text('Seller Center',
                          style: TextStyle(
                            color: Colors.white
                                .withOpacity(0.75),
                            fontSize: 13,
                            letterSpacing: 1.5,
                          )),
                      const SizedBox(height: 12),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Info tiles
                _infoTile('App Version', '1.0.0',
                    Icons.phone_android_outlined,
                    Colors.blue),
                _infoTile('Developer', 'Ghar Tak Team',
                    Icons.code_outlined,
                    Colors.purple),
                _infoTile('Platform',
                    'Android & iOS',
                    Icons.devices_outlined,
                    Colors.teal),
                _infoTile('Contact',
                    'support@gharak.com',
                    Icons.email_outlined,
                    Colors.orange),
                _infoTile('Website',
                    'www.gharak.com',
                    Icons.language_outlined,
                    Colors.green),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Text('About Ghar Tak',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: SellerColors.darkText,
                          )),
                      SizedBox(height: 10),
                      Text(
                        'Ghar Tak is a local market platform connecting buyers and sellers in Pakistan. We provide grocery, hardware, electric, restaurant, and pharmacy services delivered to your doorstep.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: SellerColors.subText,
                          fontSize: 12,
                          height: 1.6,
                        ),
                      ),
                    ],
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
              Text('About App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Ghar Tak Seller Center',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value,
      IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                    color: SellerColors.subText,
                    fontSize: 11,
                  )),
              Text(value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: SellerColors.darkText,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}