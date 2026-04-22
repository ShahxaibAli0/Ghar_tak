import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';
import '../auth/seller_login_screen.dart';
import '../shop/change_password_screen.dart';
import '../shop/shop_address_screen.dart';
import '../shop/shop_banner_screen.dart';
import '../shop/shop_profile_screen.dart';

class SellerMeScreen extends StatefulWidget {
  const SellerMeScreen({super.key});

  @override
  State<SellerMeScreen> createState() => _SellerMeScreenState();
}

class _SellerMeScreenState extends State<SellerMeScreen> {
  bool _notificationsOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildShopStats(),
            const SizedBox(height: 16),
            _buildMenuSection(
              'Shop Management',
              [
                _MenuItem(
                  Icons.store_outlined,
                  'Shop Profile',
                  'Edit name, logo, description',
                  Colors.blue,
                  () => _openScreen(const ShopProfileScreen()),
                ),
                _MenuItem(
                  Icons.photo_library_outlined,
                  'Shop Banner',
                  'Update your banner image',
                  Colors.purple,
                  () => _openScreen(const ShopBannerScreen()),
                ),
                _MenuItem(
                  Icons.location_on_outlined,
                  'Shop Address',
                  'Manage pickup location',
                  Colors.teal,
                  () => _openScreen(const ShopAddressScreen()),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildMenuSection(
              'Account Settings',
              [
                _MenuItem(
                  Icons.lock_outline,
                  'Change Password',
                  'Update your password',
                  Colors.orange,
                  () => _openScreen(const ChangePasswordScreen()),
                ),
                _MenuItem(
                  Icons.phone_outlined,
                  'Phone Number',
                  'Update contact number',
                  Colors.green,
                  () {},
                ),
                _MenuItem(
                  Icons.account_balance_outlined,
                  'Bank Account',
                  'Add or update bank details',
                  Colors.indigo,
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildNotificationToggle(),
            const SizedBox(height: 12),
            _buildMenuSection(
              'Support',
              [
                _MenuItem(
                  Icons.help_outline,
                  'Help Center',
                  'FAQs and guides',
                  Colors.blue,
                  () {},
                ),
                _MenuItem(
                  Icons.chat_outlined,
                  'Contact Support',
                  'Talk to our team',
                  Colors.green,
                  () {},
                ),
                _MenuItem(
                  Icons.privacy_tip_outlined,
                  'Privacy Policy',
                  'Read our policy',
                  Colors.grey,
                  () {},
                ),
                _MenuItem(
                  Icons.info_outline,
                  'About App',
                  'Version 1.0.0',
                  SellerColors.primary,
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildLogoutButton(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ═══ Header ═══
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
      decoration: const BoxDecoration(
        color: SellerColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                ),
                child: const Icon(Icons.store, color: Colors.white, size: 40),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit,
                      color: SellerColors.primary, size: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Ahmed Electronics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ahmed@gmail.com',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, color: Colors.white, size: 14),
                SizedBox(width: 5),
                Text(
                  'Verified Seller',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Shop Stats ═══
  Future<void> _openScreen(Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  Widget _buildShopStats() {
    return Transform.translate(
      offset: const Offset(0, -16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.07),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem('56', 'Products', Icons.inventory_2_outlined),
              _divider(),
              _statItem('248', 'Orders', Icons.receipt_long_outlined),
              _divider(),
              _statItem('4.8⭐', 'Rating', Icons.star_border),
              _divider(),
              _statItem('1.2K', 'Visitors', Icons.visibility_outlined),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: SellerColors.primary, size: 18),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: SellerColors.darkText,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: SellerColors.subText,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(height: 36, width: 1, color: Colors.grey[200]);
  }

  // ═══ Menu Section ═══
  Widget _buildMenuSection(String title, List<_MenuItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: SellerColors.subText,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final int i = entry.key;
                final _MenuItem item = entry.value;
                final bool isLast = i == items.length - 1;
                return Column(
                  children: [
                    ListTile(
                      onTap: item.onTap,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      leading: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: item.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon, color: item.color, size: 19),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: SellerColors.darkText,
                        ),
                      ),
                      subtitle: Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: SellerColors.subText,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 13,
                        color: Color(0xFFCCCCCC),
                      ),
                    ),
                    if (!isLast)
                      Divider(
                        height: 1,
                        color: Colors.grey[100],
                        indent: 56,
                        endIndent: 16,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Notification Toggle ═══
  Widget _buildNotificationToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.blue,
                size: 19,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: SellerColors.darkText,
                    ),
                  ),
                  Text(
                    'Order alerts and updates',
                    style: TextStyle(
                      fontSize: 11,
                      color: SellerColors.subText,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _notificationsOn,
              onChanged: (val) => setState(() => _notificationsOn = val),
              activeThumbColor: SellerColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  // ═══ Logout ═══
  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton.icon(
          onPressed: () => _logoutDialog(context),
          icon: const Icon(Icons.logout, color: Colors.red, size: 18),
          label: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red, width: 1.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
    );
  }

  void _logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title:
            const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: SellerColors.subText)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SellerLoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  _MenuItem(this.icon, this.title, this.subtitle, this.color, this.onTap);
}
