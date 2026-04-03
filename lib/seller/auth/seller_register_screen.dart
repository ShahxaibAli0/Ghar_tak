import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';
import 'seller_login_screen.dart';

class SellerRegisterScreen extends StatefulWidget {
  const SellerRegisterScreen({super.key});

  @override
  State<SellerRegisterScreen> createState() => _SellerRegisterScreenState();
}

class _SellerRegisterScreenState extends State<SellerRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String? selectedCategory;

  final List<String> categories = [
    'Grocery',
    'Hardware',
    'Electric',
    'Restaurant',
    'Pharmacies',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SellerColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            // ═══ Green Top Header ═══
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
              decoration: const BoxDecoration(
                color: SellerColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.store,
                        color: Colors.white, size: 52),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'GHAR TAK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Seller Registration',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),

            // ═══ Form ═══
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _sectionLabel('Shop Information'),
                    const SizedBox(height: 12),
                    _buildField('Shop Name', Icons.store_mall_directory),
                    _buildField('Owner Name', Icons.person),

                    const SizedBox(height: 8),
                    _sectionLabel('Contact Details'),
                    const SizedBox(height: 12),
                    _buildField('Email Address', Icons.email,
                        keyboardType: TextInputType.emailAddress),
                    _buildField('Phone Number', Icons.phone,
                        keyboardType: TextInputType.phone),
                    _buildField('CNIC Number', Icons.credit_card,
                        keyboardType: TextInputType.number),

                    const SizedBox(height: 8),
                    _sectionLabel('Security'),
                    const SizedBox(height: 12),
                    _buildPasswordField(),

                    const SizedBox(height: 8),
                    _sectionLabel('Shop Category'),
                    const SizedBox(height: 12),

                    // ── Category Dropdown ──
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: _inputDecoration(
                          'Select Category', Icons.category),
                      dropdownColor: SellerColors.white,
                      borderRadius: BorderRadius.circular(12),
                      items: categories
                          .map((cat) => DropdownMenuItem(
                              value: cat, child: Text(cat)))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => selectedCategory = val),
                      validator: (val) =>
                          val == null ? 'Please select a category' : null,
                    ),

                    const SizedBox(height: 32),

                    // ── Register Button ──
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SellerColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 4,
                          shadowColor:
                              SellerColors.primary.withOpacity(0.4),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const SellerLoginScreen()),
                            );
                          }
                        },
                        child: const Text(
                          'Create Seller Account',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Already Seller ──
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already a seller? ',
                              style: TextStyle(
                                  color: SellerColors.subText,
                                  fontSize: 14)),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const SellerLoginScreen()),
                            ),
                            child: const Text(
                              'Login Here',
                              style: TextStyle(
                                color: SellerColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Label ──
  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: SellerColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 13,
        letterSpacing: 0.5,
      ),
    );
  }

  // ── Text Field ──
  Widget _buildField(String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: _inputDecoration(label, icon),
        validator: (val) =>
            val == null || val.isEmpty ? 'Enter $label' : null,
      ),
    );
  }

  // ── Password Field ──
  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        obscureText: _obscurePassword,
        decoration: _inputDecoration('Password', Icons.lock).copyWith(
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: SellerColors.primary,
            ),
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        validator: (val) => val != null && val.length < 6
            ? 'Minimum 6 characters required'
            : null,
      ),
    );
  }

  // ── Input Decoration ──
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: SellerColors.primary, size: 20),
      filled: true,
      fillColor: SellerColors.lightGreen,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: SellerColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      labelStyle: const TextStyle(color: SellerColors.subText, fontSize: 14),
    );
  }
}