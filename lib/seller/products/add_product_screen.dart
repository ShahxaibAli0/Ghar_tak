import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
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
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildImagePicker(),
                    const SizedBox(height: 16),
                    _buildSection(
                      'Product Information',
                      [
                        _buildField('Product Name', Icons.inventory_2_outlined),
                        _buildField('Product Description',
                            Icons.description_outlined,
                            maxLines: 3),
                        _buildDropdown(),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildSection(
                      'Pricing & Stock',
                      [
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                  'Price (Rs.)', Icons.attach_money,
                                  keyboardType: TextInputType.number),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildField(
                                  'Stock Qty', Icons.numbers,
                                  keyboardType: TextInputType.number),
                            ),
                          ],
                        ),
                        _buildField('Discount % (Optional)',
                            Icons.local_offer_outlined,
                            keyboardType: TextInputType.number,
                            isRequired: false),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildSection(
                      'Delivery Info',
                      [
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                  'Weight (kg)', Icons.scale_outlined,
                                  keyboardType: TextInputType.number,
                                  isRequired: false),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildField(
                                  'Delivery Days', Icons.local_shipping_outlined,
                                  keyboardType: TextInputType.number,
                                  isRequired: false),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    _buildSubmitButton(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
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
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 14),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add New Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Fill in product details',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  // ═══ Image Picker ═══
  Widget _buildImagePicker() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
          const Text('Product Images',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: SellerColors.darkText,
              )),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main Image Box
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: SellerColors.lightGreen,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: SellerColors.primary.withOpacity(0.4),
                        width: 1.5,
                        style: BorderStyle.solid),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined,
                          color: SellerColors.primary, size: 36),
                      SizedBox(height: 6),
                      Text('Main Image',
                          style: TextStyle(
                            color: SellerColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Extra Images
              Column(
                children: [
                  _extraImageBox(),
                  const SizedBox(height: 10),
                  _extraImageBox(),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  _extraImageBox(),
                  const SizedBox(height: 10),
                  _extraImageBox(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Upload up to 5 product images',
              style: TextStyle(color: SellerColors.subText, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _extraImageBox() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: SellerColors.lightGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: SellerColors.primary.withOpacity(0.3), width: 1),
        ),
        child: const Icon(Icons.add,
            color: SellerColors.primary, size: 22),
      ),
    );
  }

  // ═══ Section Card ═══
  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
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
          Row(
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
              Text(title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: SellerColors.darkText,
                  )),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  // ═══ Text Field ═══
  Widget _buildField(String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text,
      int maxLines = 1,
      bool isRequired = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: _inputDecoration(label, icon),
        validator: isRequired
            ? (val) =>
                val == null || val.isEmpty ? 'Please enter $label' : null
            : null,
      ),
    );
  }

  // ═══ Category Dropdown ═══
  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: selectedCategory,
        decoration: _inputDecoration('Category', Icons.category_outlined),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        items: categories
            .map((cat) =>
                DropdownMenuItem(value: cat, child: Text(cat)))
            .toList(),
        onChanged: (val) => setState(() => selectedCategory = val),
        validator: (val) =>
            val == null ? 'Please select a category' : null,
      ),
    );
  }

  // ═══ Submit Button ═══
  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: SellerColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          elevation: 4,
          shadowColor: SellerColors.primary.withOpacity(0.4),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Product added successfully!'),
                  ],
                ),
                backgroundColor: SellerColors.primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
            Navigator.pop(context);
          }
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined,
                color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text('Publish Product',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  // ═══ Input Decoration ═══
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
      labelStyle:
          const TextStyle(color: SellerColors.subText, fontSize: 14),
    );
  }
}