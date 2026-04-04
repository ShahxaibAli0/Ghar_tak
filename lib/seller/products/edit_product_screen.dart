import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class EditProductScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory;
  bool _isActive = true;

  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _discountController;
  late TextEditingController _weightController;
  late TextEditingController _deliveryController;

  final List<String> categories = [
    'Grocery',
    'Hardware',
    'Electric',
    'Restaurant',
    'Pharmacies',
  ];

  @override
  void initState() {
    super.initState();
    // ── Pre-fill existing product data ──
    _nameController =
        TextEditingController(text: widget.product['name'] ?? '');
    _descController = TextEditingController(
        text: widget.product['description'] ?? 'Best quality product.');
    _priceController = TextEditingController(
        text: widget.product['price']
                ?.toString()
                .replaceAll('Rs. ', '')
                .replaceAll(',', '') ??
            '');
    _stockController = TextEditingController(
        text: widget.product['stock']?.toString() ?? '');
    _discountController =
        TextEditingController(text: widget.product['discount'] ?? '0');
    _weightController =
        TextEditingController(text: widget.product['weight'] ?? '1');
    _deliveryController =
        TextEditingController(text: widget.product['delivery'] ?? '2');
    selectedCategory = widget.product['category'];
    _isActive = widget.product['status'] == 'Active';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _discountController.dispose();
    _weightController.dispose();
    _deliveryController.dispose();
    super.dispose();
  }

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
                    _buildImageSection(),
                    const SizedBox(height: 14),
                    _buildStatusToggle(),
                    const SizedBox(height: 14),
                    _buildSection(
                      'Product Information',
                      Icons.inventory_2_outlined,
                      [
                        _buildField(
                          'Product Name',
                          Icons.drive_file_rename_outline,
                          _nameController,
                        ),
                        _buildField(
                          'Product Description',
                          Icons.description_outlined,
                          _descController,
                          maxLines: 3,
                        ),
                        _buildDropdown(),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildSection(
                      'Pricing & Stock',
                      Icons.attach_money,
                      [
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                'Price (Rs.)',
                                Icons.attach_money,
                                _priceController,
                                keyboard: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildField(
                                'Stock Qty',
                                Icons.numbers,
                                _stockController,
                                keyboard: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        _buildField(
                          'Discount % (Optional)',
                          Icons.local_offer_outlined,
                          _discountController,
                          keyboard: TextInputType.number,
                          isRequired: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildSection(
                      'Delivery Info',
                      Icons.local_shipping_outlined,
                      [
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                'Weight (kg)',
                                Icons.scale_outlined,
                                _weightController,
                                keyboard: TextInputType.number,
                                isRequired: false,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildField(
                                'Delivery Days',
                                Icons.local_shipping_outlined,
                                _deliveryController,
                                keyboard: TextInputType.number,
                                isRequired: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildButtons(context),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.product['name'] ?? '',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Delete Button
          GestureDetector(
            onTap: () => _deleteDialog(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.delete_outline,
                  color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Image Section ═══
  Widget _buildImageSection() {
    return Container(
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
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Product Images',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: SellerColors.darkText,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Main existing image
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: (widget.product['color'] as Color?)
                              ?.withOpacity(0.12) ??
                          SellerColors.lightGreen,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: SellerColors.primary.withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      widget.product['image'] as IconData? ??
                          Icons.image,
                      color: widget.product['color'] as Color? ??
                          SellerColors.primary,
                      size: 40,
                    ),
                  ),
                  // Edit badge
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: SellerColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit,
                          color: Colors.white, size: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Add more images
              Column(
                children: [
                  _extraImageBox(),
                  const SizedBox(height: 10),
                  _extraImageBox(),
                ],
              ),
              const SizedBox(width: 10),
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
          const Text(
            'Tap main image to change it',
            style: TextStyle(
              color: SellerColors.subText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _extraImageBox() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: SellerColors.lightGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: SellerColors.primary.withOpacity(0.3),
          ),
        ),
        child: const Icon(Icons.add,
            color: SellerColors.primary, size: 20),
      ),
    );
  }

  // ═══ Status Toggle ═══
  Widget _buildStatusToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isActive
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _isActive
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: _isActive ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Product Status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: SellerColors.darkText,
                  ),
                ),
                Text(
                  _isActive
                      ? 'Active — Users ko dikh raha hai'
                      : 'Inactive — Users ko nahi dikh raha',
                  style: TextStyle(
                    color: _isActive ? Colors.green : Colors.red,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _isActive,
            onChanged: (val) => setState(() => _isActive = val),
            activeColor: SellerColors.primary,
          ),
        ],
      ),
    );
  }

  // ═══ Section Card ═══
  Widget _buildSection(
      String title, IconData icon, List<Widget> children) {
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
              Icon(icon, color: SellerColors.primary, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: SellerColors.darkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  // ═══ Text Field ═══
  Widget _buildField(
    String label,
    IconData icon,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
    bool isRequired = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: _inputDecoration(label, icon),
        validator: isRequired
            ? (val) => val == null || val.isEmpty
                ? 'Please enter $label'
                : null
            : null,
      ),
    );
  }

  // ═══ Dropdown ═══
  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: selectedCategory,
        decoration:
            _inputDecoration('Category', Icons.category_outlined),
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

  // ═══ Save + Delete Buttons ═══
  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        // Save Button
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton.icon(
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
                        Text('Product updated successfully!'),
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
            icon: const Icon(Icons.save_outlined,
                color: Colors.white, size: 20),
            label: const Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Discard Button
        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                  color: SellerColors.subText, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close,
                color: SellerColors.subText, size: 20),
            label: const Text(
              'Discard Changes',
              style: TextStyle(
                fontSize: 15,
                color: SellerColors.subText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ═══ Delete Dialog ═══
  void _deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('Delete Product',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
            'Are you sure you want to delete "${widget.product['name']}"? This cannot be undone.'),
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
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.delete, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Product deleted!'),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Text('Delete',
                style: TextStyle(color: Colors.white)),
          ),
        ],
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