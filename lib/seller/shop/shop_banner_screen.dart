import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/seller_colors.dart';
import 'seller_shop_profile_store.dart';
import 'shop_form_widgets.dart';

class ShopBannerScreen extends StatefulWidget {
  const ShopBannerScreen({super.key});

  @override
  State<ShopBannerScreen> createState() => _ShopBannerScreenState();
}

class _ShopBannerScreenState extends State<ShopBannerScreen> {
  final _picker = ImagePicker();
  String? _bannerPath;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  Future<void> _loadBanner() async {
    final profile = await SellerShopProfileStore.load();
    if (!mounted) return;
    setState(() => _bannerPath = profile.bannerPath);
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
                  subtitle: const Text('Capture a banner image'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickBanner(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: SellerColors.lightGreen,
                    child:
                        Icon(Icons.photo_library, color: SellerColors.primary),
                  ),
                  title: const Text('Choose From Gallery'),
                  subtitle: const Text('Select a banner image'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickBanner(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickBanner(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source, imageQuality: 88);
      if (image == null || !mounted) return;
      setState(() => _bannerPath = image.path);
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

  Future<void> _saveBanner() async {
    final path = _bannerPath;
    if (path == null || path.isEmpty) {
      showShopSnackBar(context, 'Please upload a banner image.', isError: true);
      return;
    }

    setState(() => _isSaving = true);
    await SellerShopProfileStore.saveBanner(path);

    if (!mounted) return;
    setState(() => _isSaving = false);
    showShopSnackBar(context, 'Shop banner saved successfully.');
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          const ShopFormHeader(
            title: 'Shop Banner',
            subtitle: 'Upload or change banner image',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ShopFormCard(
                    title: 'Banner Preview',
                    icon: Icons.photo_library_outlined,
                    children: [
                      _buildBannerPreview(),
                      const SizedBox(height: 14),
                      OutlinedButton.icon(
                        onPressed: _showImageSourceSheet,
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        label: Text(
                          _bannerPath == null
                              ? 'Upload Banner'
                              : 'Change Banner',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: SellerColors.primary,
                          side: const BorderSide(color: SellerColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ShopSaveButton(
                    label: 'Save Banner',
                    isLoading: _isSaving,
                    onPressed: _saveBanner,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerPreview() {
    final path = _bannerPath;
    final hasImage = path != null && path.isNotEmpty && File(path).existsSync();

    return GestureDetector(
      onTap: _showImageSourceSheet,
      child: Container(
        width: double.infinity,
        height: 190,
        decoration: BoxDecoration(
          color: SellerColors.lightGreen,
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: SellerColors.primary.withValues(alpha: 0.3)),
        ),
        child: hasImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(path),
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _emptyBannerPreview(),
                ),
              )
            : _emptyBannerPreview(),
      ),
    );
  }

  Widget _emptyBannerPreview() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          color: SellerColors.primary,
          size: 42,
        ),
        SizedBox(height: 8),
        Text(
          'Tap to upload banner',
          style: TextStyle(
            color: SellerColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Preview appears here before saving',
          style: TextStyle(color: SellerColors.subText, fontSize: 12),
        ),
      ],
    );
  }
}
