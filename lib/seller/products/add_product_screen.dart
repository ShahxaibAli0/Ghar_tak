import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../widgets/seller_colors.dart';
import 'my_products_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  static const int _maxImages = 8;

  final _formKey = GlobalKey<FormState>();
  final _imagesFieldKey = GlobalKey<FormFieldState<List<XFile>>>();
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _discountController = TextEditingController();
  final _weightController = TextEditingController();
  final _deliveryController = TextEditingController();

  String? selectedCategory;
  bool _isSubmitting = false;

  final List<String> categories = [
    'Grocery',
    'Hardware',
    'Electric',
    'Restaurant',
    'Pharmacies',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _discountController.dispose();
    _weightController.dispose();
    _deliveryController.dispose();
    super.dispose();
  }

  Future<void> _showImageSourceSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: SellerColors.lightGreen,
                    child: Icon(Icons.camera_alt, color: SellerColors.primary),
                  ),
                  title: const Text('Take Photo'),
                  subtitle: const Text('Use the camera for a new image'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickFromCamera();
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: SellerColors.lightGreen,
                    child:
                        Icon(Icons.photo_library, color: SellerColors.primary),
                  ),
                  title: const Text('Choose From Gallery'),
                  subtitle: const Text('Select one or more existing images'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickFromGallery();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickFromCamera() async {
    if (!_canAddMoreImages()) return;

    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (image == null || !mounted) return;

      setState(() => _selectedImages.add(image));
      _syncImageField();
    } catch (_) {
      _showSnackBar('Unable to open camera. Please try again.', isError: true);
    }
  }

  Future<void> _pickFromGallery() async {
    if (!_canAddMoreImages()) return;

    try {
      final images = await _picker.pickMultiImage(imageQuality: 85);
      if (images.isEmpty || !mounted) return;

      final existingPaths = _selectedImages.map((image) => image.path).toSet();
      final remainingSlots = _maxImages - _selectedImages.length;
      final newImages = images
          .where((image) => !existingPaths.contains(image.path))
          .take(remainingSlots)
          .toList();

      if (newImages.isEmpty) {
        _showSnackBar('Those images are already selected.', isError: true);
        return;
      }

      setState(() => _selectedImages.addAll(newImages));
      _syncImageField();

      if (images.length > newImages.length) {
        _showSnackBar('Only $_maxImages images can be added.');
      }
    } catch (_) {
      _showSnackBar('Unable to open gallery. Please try again.', isError: true);
    }
  }

  bool _canAddMoreImages() {
    if (_selectedImages.length < _maxImages) return true;
    _showSnackBar('You can add up to $_maxImages product images.',
        isError: true);
    return false;
  }

  void _removeImage(int index) {
    setState(() => _selectedImages.removeAt(index));
    _syncImageField();
  }

  void _syncImageField() {
    _imagesFieldKey.currentState?.didChange(List<XFile>.from(_selectedImages));
  }

  Future<void> _submitProduct() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      _showSnackBar('Please fix the highlighted fields.', isError: true);
      return;
    }

    setState(() => _isSubmitting = true);

    final stock = int.parse(_stockController.text.trim());
    final product = {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'category': selectedCategory!,
      'price': 'Rs. ${_priceController.text.trim()}',
      'stock': stock,
      'status': stock > 0 ? 'Active' : 'Out of Stock',
      'imagePaths': _selectedImages.map((image) => image.path).toList(),
      'imagePath': _selectedImages.isEmpty ? '' : _selectedImages.first.path,
      'discount': _discountController.text.trim(),
      'weight': _weightController.text.trim(),
      'delivery': _deliveryController.text.trim(),
    };

    await context.read<ProductProvider>().addProduct(product);

    if (!mounted) return;
    setState(() => _isSubmitting = false);
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle,
                  color: SellerColors.primary, size: 56),
            ),
            const SizedBox(height: 16),
            const Text(
              'Product Published!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Your product is now live and visible\nto customers.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MyProductsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: SellerColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Great!',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Grocery':
        return Icons.local_grocery_store;
      case 'Hardware':
        return Icons.hardware;
      case 'Electric':
        return Icons.electrical_services;
      case 'Restaurant':
        return Icons.restaurant;
      case 'Pharmacies':
        return Icons.medication;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Grocery':
        return Colors.green;
      case 'Hardware':
        return Colors.blueGrey;
      case 'Electric':
        return Colors.amber;
      case 'Restaurant':
        return Colors.deepOrange;
      case 'Pharmacies':
        return Colors.red;
      default:
        return SellerColors.primary;
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? Colors.red : SellerColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  String? _requiredText(String? value, String label, {int minLength = 1}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter $label';
    if (text.length < minLength) return '$label is too short';
    return null;
  }

  String? _positiveNumber(String? value, String label) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter $label';
    final number = num.tryParse(text);
    if (number == null || number <= 0) return 'Enter a valid $label';
    return null;
  }

  String? _stockValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter stock quantity';
    final stock = int.tryParse(text);
    if (stock == null || stock < 0) return 'Enter valid stock';
    return null;
  }

  String? _optionalNumber(
    String? value,
    String label, {
    num? min,
    num? max,
    bool wholeNumber = false,
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;

    final number = wholeNumber ? int.tryParse(text) : num.tryParse(text);
    if (number == null) return 'Enter a valid $label';
    if (min != null && number < min) return '$label must be at least $min';
    if (max != null && number > max) return '$label must be $max or less';
    return null;
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    _buildImagePickerSection(),
                    const SizedBox(height: 16),
                    _buildSection(
                      'Product Information',
                      [
                        _buildField(
                          'Product Name',
                          Icons.inventory_2_outlined,
                          controller: _nameController,
                          validator: (value) =>
                              _requiredText(value, 'product name'),
                        ),
                        _buildField(
                          'Product Description',
                          Icons.description_outlined,
                          controller: _descriptionController,
                          maxLines: 3,
                          validator: (value) => _requiredText(
                            value,
                            'product description',
                            minLength: 10,
                          ),
                        ),
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
                                'Price (Rs.)',
                                Icons.attach_money,
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    _positiveNumber(value, 'price'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildField(
                                'Stock Qty',
                                Icons.numbers,
                                controller: _stockController,
                                keyboardType: TextInputType.number,
                                validator: _stockValidator,
                              ),
                            ),
                          ],
                        ),
                        _buildField(
                          'Discount % (Optional)',
                          Icons.local_offer_outlined,
                          controller: _discountController,
                          keyboardType: TextInputType.number,
                          validator: (value) => _optionalNumber(
                            value,
                            'discount',
                            min: 0,
                            max: 100,
                          ),
                        ),
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
                                'Weight (kg)',
                                Icons.scale_outlined,
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                validator: (value) => _optionalNumber(
                                  value,
                                  'weight',
                                  min: 0.1,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildField(
                                'Delivery Days',
                                Icons.local_shipping_outlined,
                                controller: _deliveryController,
                                keyboardType: TextInputType.number,
                                validator: (value) => _optionalNumber(
                                  value,
                                  'delivery days',
                                  min: 1,
                                  wholeNumber: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    _buildSubmitButton(),
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
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Fill in product details',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePickerSection() {
    return FormField<List<XFile>>(
      key: _imagesFieldKey,
      initialValue: _selectedImages,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (_) =>
          _selectedImages.isEmpty ? 'Add at least one product image' : null,
      builder: (field) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: field.hasError ? Colors.red : Colors.transparent,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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
                  const Expanded(
                    child: Text(
                      'Product Images',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: SellerColors.darkText,
                      ),
                    ),
                  ),
                  Text(
                    '${_selectedImages.length}/$_maxImages',
                    style: const TextStyle(
                      color: SellerColors.subText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_selectedImages.isEmpty)
                _emptyImagePicker()
              else
                _selectedImageGrid(),
              if (field.hasError) ...[
                const SizedBox(height: 8),
                Text(
                  field.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _emptyImagePicker() {
    return InkWell(
      onTap: _showImageSourceSheet,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        decoration: BoxDecoration(
          color: SellerColors.lightGreen,
          borderRadius: BorderRadius.circular(14),
          border:
              Border.all(color: SellerColors.primary.withValues(alpha: 0.35)),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: SellerColors.primary,
              size: 40,
            ),
            SizedBox(height: 8),
            Text(
              'Add Product Images',
              style: TextStyle(
                color: SellerColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Use camera or gallery',
              style: TextStyle(color: SellerColors.subText, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedImageGrid() {
    final showAddTile = _selectedImages.length < _maxImages;
    final itemCount = _selectedImages.length + (showAddTile ? 1 : 0);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        if (showAddTile && index == itemCount - 1) {
          return _addImageTile();
        }
        return _imageTile(index);
      },
    );
  }

  Widget _addImageTile() {
    return InkWell(
      onTap: _showImageSourceSheet,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: SellerColors.lightGreen,
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: SellerColors.primary.withValues(alpha: 0.35)),
        ),
        child: const Icon(
          Icons.add_photo_alternate_outlined,
          color: SellerColors.primary,
          size: 28,
        ),
      ),
    );
  }

  Widget _imageTile(int index) {
    final image = _selectedImages[index];
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(image.path),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade100,
                child: const Icon(
                  Icons.broken_image_outlined,
                  color: SellerColors.subText,
                ),
              ),
            ),
          ),
        ),
        if (index == 0)
          Positioned(
            left: 6,
            bottom: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: SellerColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Cover',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        Positioned(
          right: 5,
          top: 5,
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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

  Widget _buildField(
    String label,
    IconData icon, {
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    final isMultiline = maxLines > 1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
        maxLines: maxLines,
        textInputAction:
            isMultiline ? TextInputAction.newline : TextInputAction.next,
        decoration: _inputDecoration(label, icon),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        initialValue: selectedCategory,
        decoration: _inputDecoration('Category', Icons.category_outlined),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        items: categories
            .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
            .toList(),
        onChanged: (val) => setState(() => selectedCategory = val),
        validator: (val) => val == null ? 'Please select a category' : null,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: SellerColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 4,
          shadowColor: SellerColors.primary.withValues(alpha: 0.4),
        ),
        onPressed: _isSubmitting ? null : _submitProduct,
        child: _isSubmitting
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.4,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Publish Product',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: SellerColors.primary, size: 20),
      filled: true,
      fillColor: SellerColors.lightGreen,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SellerColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      labelStyle: const TextStyle(color: SellerColors.subText, fontSize: 14),
    );
  }
}
