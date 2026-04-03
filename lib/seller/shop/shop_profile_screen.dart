import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';
import '../auth/seller_login_screen.dart';

class ShopProfileScreen extends StatefulWidget {
  const ShopProfileScreen({super.key});

  @override
  State<ShopProfileScreen> createState() => _ShopProfileScreenState();
}

class _ShopProfileScreenState extends State<ShopProfileScreen> {
  bool _isEditing = false;

  final TextEditingController _shopName =
      TextEditingController(text: 'Ahmed Electronics');
  final TextEditingController _ownerName =
      TextEditingController(text: 'Ahmed Khan');
  final TextEditingController _phone =
      TextEditingController(text: '0300-1234567');
  final TextEditingController _email =
      TextEditingController(text: 'ahmed@gmail.com');
  final TextEditingController _address =
      TextEditingController(text: 'Shop 12, Gulshan-e-Iqbal, Karachi');
  final TextEditingController _description = TextEditingController(
      text: 'Best electronics shop in Karachi. Quality products at best prices.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildShopBanner(),
            const SizedBox(height: 16),
            _buildStatsRow(),
            const SizedBox(height: 16),
            _buildInfoSection(),
            const SizedBox(height: 16),
            _buildSettingsSection(context),
            const SizedBox(height: 16),
            _buildLogoutButton(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ═══ Header ═══
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 55, 20, 20),
      decoration: const BoxDecoration(
        color: SellerColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shop Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 4),
              Text('Manage your store info',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
          GestureDetector(
            onTap: () => setState(() => _isEditing = !_isEditing),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: _isEditing
                    ? Colors.white
                    : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    _isEditing ? Icons.check : Icons.edit_outlined,
                    color: _isEditing
                        ? SellerColors.primary
                        : Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _isEditing ? 'Save' : 'Edit',
                    style: TextStyle(
                      color: _isEditing
                          ? SellerColors.primary
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Shop Banner + Logo ═══
  Widget _buildShopBanner() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // Banner
        GestureDetector(
          onTap: _isEditing ? () {} : null,
          child: Container(
            height: 130,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00A651), Color(0xFF007A3D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _isEditing
                ? const Center(
                    child: Icon(Icons.add_photo_alternate,
                        color: Colors.white54, size: 36),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Electric',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            )),
                        Text(_shopName.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
          ),
        ),

        // Logo Circle
        Positioned(
          bottom: -36,
          child: GestureDetector(
            onTap: _isEditing ? () {} : null,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: SellerColors.lightGreen,
                child: _isEditing
                    ? const Icon(Icons.camera_alt,
                        color: SellerColors.primary, size: 28)
                    : const Icon(Icons.store,
                        color: SellerColors.primary, size: 36),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ═══ Stats Row ═══
  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _statItem('56', 'Products', Icons.inventory_2_outlined),
            _verticalDivider(),
            _statItem('248', 'Orders', Icons.receipt_long_outlined),
            _verticalDivider(),
            _statItem('4.8 ⭐', 'Rating', Icons.star_border),
            _verticalDivider(),
            _statItem('12K', 'Visitors', Icons.visibility_outlined),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: SellerColors.primary, size: 20),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: SellerColors.darkText,
            )),
        Text(label,
            style: const TextStyle(
              color: SellerColors.subText,
              fontSize: 11,
            )),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[200],
    );
  }

  // ═══ Info Section ═══
  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Shop Information', Icons.store_outlined),
            const SizedBox(height: 14),
            _buildInfoField('Shop Name', _shopName,
                Icons.store_mall_directory_outlined),
            _buildInfoField(
                'Owner Name', _ownerName, Icons.person_outlined),
            _buildInfoField('Phone', _phone, Icons.phone_outlined,
                keyboard: TextInputType.phone),
            _buildInfoField('Email', _email, Icons.email_outlined,
                keyboard: TextInputType.emailAddress),
            _buildInfoField('Address', _address, Icons.location_on_outlined,
                maxLines: 2),
            _buildInfoField(
                'Description', _description, Icons.description_outlined,
                maxLines: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _isEditing
          ? TextFormField(
              controller: controller,
              keyboardType: keyboard,
              maxLines: maxLines,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: label,
                prefixIcon:
                    Icon(icon, color: SellerColors.primary, size: 20),
                filled: true,
                fillColor: SellerColors.lightGreen,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14, horizontal: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: SellerColors.primary, width: 2),
                ),
                labelStyle: const TextStyle(
                    color: SellerColors.subText, fontSize: 13),
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: SellerColors.primary, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: const TextStyle(
                            color: SellerColors.subText,
                            fontSize: 11,
                          )),
                      const SizedBox(height: 2),
                      Text(controller.text,
                          style: const TextStyle(
                            color: SellerColors.darkText,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(height: 10),
                      Divider(
                          height: 1, color: Colors.grey[100]),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // ═══ Settings Section ═══
  Widget _buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _settingsTile(
                Icons.notifications_outlined, 'Notifications', Colors.blue),
            _divider(),
            _settingsTile(
                Icons.lock_outline, 'Change Password', Colors.orange),
            _divider(),
            _settingsTile(
                Icons.help_outline, 'Help & Support', Colors.purple),
            _divider(),
            _settingsTile(
                Icons.privacy_tip_outlined, 'Privacy Policy', Colors.teal),
            _divider(),
            _settingsTile(
                Icons.info_outline, 'About App', SellerColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: SellerColors.darkText,
          )),
      trailing: const Icon(Icons.arrow_forward_ios,
          size: 14, color: SellerColors.subText),
      onTap: () {},
    );
  }

  Widget _divider() =>
      Divider(height: 1, color: Colors.grey[100], indent: 16, endIndent: 16);

  // ═══ Section Title ═══
  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: SellerColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, color: SellerColors.primary, size: 18),
        const SizedBox(width: 6),
        Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: SellerColors.darkText,
            )),
      ],
    );
  }

  // ═══ Logout Button ═══
  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          onPressed: () => _logoutDialog(context),
          icon: const Icon(Icons.logout, color: Colors.red, size: 20),
          label: const Text('Logout',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red, width: 1.5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
    );
  }

  void _logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content:
            const Text('Are you sure you want to logout?'),
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
                MaterialPageRoute(
                    builder: (_) => const SellerLoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Logout',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}