import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/seller_colors.dart';
import 'seller_shop_profile_store.dart';
import 'shop_form_widgets.dart';

class ShopProfileScreen extends StatefulWidget {
  const ShopProfileScreen({super.key});

  @override
  State<ShopProfileScreen> createState() => _ShopProfileScreenState();
}

class _ShopProfileScreenState extends State<ShopProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _logoFieldKey = GlobalKey<FormFieldState<String>>();
  final _picker = ImagePicker();
  final _shopNameController = TextEditingController(
    text: SellerShopProfileStore.defaultShopName,
  );
  final _descriptionController = TextEditingController(
    text: SellerShopProfileStore.defaultShopDescription,
  );

  String? _logoPath;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final profile = await SellerShopProfileStore.load();
    if (!mounted) return;

    setState(() {
      _shopNameController.text = profile.shopName;
      _descriptionController.text = profile.shopDescription;
      _logoPath = profile.logoPath;
    });
    _logoFieldKey.currentState?.didChange(_logoPath);
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
                  subtitle: const Text('Capture a new shop logo'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickLogo(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: SellerColors.lightGreen,
                    child:
                        Icon(Icons.photo_library, color: SellerColors.primary),
                  ),
                  title: const Text('Choose From Gallery'),
                  subtitle: const Text('Select an existing logo'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickLogo(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickLogo(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source, imageQuality: 85);
      if (image == null || !mounted) return;

      setState(() => _logoPath = image.path);
      _logoFieldKey.currentState?.didChange(_logoPath);
    } catch (_) {
      showShopSnackBar(
        context,
        source == ImageSource.camera
            ? 'Unable to open camera. Please try again.'
            : 'Unable to open gallery. Please try again.',
        isError: true,
      );
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      showShopSnackBar(context, 'Please fix the highlighted fields.',
          isError: true);
      return;
    }

    setState(() => _isSaving = true);
    await SellerShopProfileStore.saveProfile(
      shopName: _shopNameController.text,
      shopDescription: _descriptionController.text,
      logoPath: _logoPath!,
    );

    if (!mounted) return;
    setState(() => _isSaving = false);
    showShopSnackBar(context, 'Shop profile saved successfully.');
    Navigator.pop(context, true);
  }

  String? _requiredText(String? value, String label, {int minLength = 1}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter $label';
    if (text.length < minLength) return '$label is too short';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          const ShopFormHeader(
            title: 'Shop Profile',
            subtitle: 'Edit name, logo, description',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    ShopFormCard(
                      title: 'Shop Details',
                      icon: Icons.store_outlined,
                      children: [
                        _buildLogoPicker(),
                        const SizedBox(height: 18),
                        ShopTextField(
                          controller: _shopNameController,
                          label: 'Shop Name',
                          icon: Icons.store_mall_directory_outlined,
                          validator: (value) =>
                              _requiredText(value, 'shop name', minLength: 3),
                        ),
                        ShopTextField(
                          controller: _descriptionController,
                          label: 'Shop Description',
                          icon: Icons.description_outlined,
                          maxLines: 4,
                          validator: (value) => _requiredText(
                            value,
                            'shop description',
                            minLength: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ShopSaveButton(
                      label: 'Save Shop Profile',
                      isLoading: _isSaving,
                      onPressed: _saveProfile,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoPicker() {
    return FormField<String>(
      key: _logoFieldKey,
      initialValue: _logoPath,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (_) =>
          _logoPath == null || _logoPath!.isEmpty ? 'Please upload logo' : null,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: _showImageSourceSheet,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: SellerColors.lightGreen,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: field.hasError
                              ? Colors.red
                              : SellerColors.primary.withValues(alpha: 0.35),
                          width: 2,
                        ),
                      ),
                      child: _logoPreview(),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 4,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: SellerColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Shop Logo',
              style: TextStyle(
                color: SellerColors.darkText,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap to upload from camera or gallery',
              style: TextStyle(color: SellerColors.subText, fontSize: 12),
            ),
            if (field.hasError) ...[
              const SizedBox(height: 8),
              Text(
                field.errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _logoPreview() {
    final path = _logoPath;
    if (path != null && path.isNotEmpty && File(path).existsSync()) {
      return ClipOval(
        child: Image.file(
          File(path),
          width: 112,
          height: 112,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.store,
            color: SellerColors.primary,
            size: 46,
          ),
        ),
      );
    }

    return const Icon(Icons.store, color: SellerColors.primary, size: 46);
  }
}
