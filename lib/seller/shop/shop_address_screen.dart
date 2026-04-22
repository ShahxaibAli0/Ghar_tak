import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/seller_colors.dart';
import 'shop_form_widgets.dart';

class ShopAddressScreen extends StatefulWidget {
  const ShopAddressScreen({super.key});

  @override
  State<ShopAddressScreen> createState() => _ShopAddressScreenState();
}

class _ShopAddressScreenState extends State<ShopAddressScreen> {
  static const _streetKey = 'seller_shop_address_street';
  static const _areaKey = 'seller_shop_address_area';
  static const _cityKey = 'seller_shop_address_city';
  static const _postalCodeKey = 'seller_shop_address_postal_code';
  static const _coordinatesKey = 'seller_shop_address_coordinates';

  final _formKey = GlobalKey<FormState>();
  final _streetController =
      TextEditingController(text: 'Shop 12, Gulshan-e-Iqbal');
  final _areaController = TextEditingController(text: 'Block 13-D');
  final _cityController = TextEditingController(text: 'Karachi');
  final _postalCodeController = TextEditingController();
  final _coordinatesController = TextEditingController();

  bool _isSaving = false;
  bool _isLocating = false;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _coordinatesController.dispose();
    super.dispose();
  }

  Future<void> _loadAddress() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      _streetController.text =
          prefs.getString(_streetKey) ?? _streetController.text;
      _areaController.text = prefs.getString(_areaKey) ?? _areaController.text;
      _cityController.text = prefs.getString(_cityKey) ?? _cityController.text;
      _postalCodeController.text = prefs.getString(_postalCodeKey) ?? '';
      _coordinatesController.text = prefs.getString(_coordinatesKey) ?? '';
    });
  }

  Future<void> _useCurrentLocation() async {
    setState(() => _isLocating = true);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (!mounted) return;
        showShopSnackBar(context, 'Please enable location services.',
            isError: true);
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        showShopSnackBar(context, 'Location permission denied.', isError: true);
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        showShopSnackBar(
          context,
          'Location permission is permanently denied.',
          isError: true,
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (!mounted) return;

      setState(() {
        _coordinatesController.text =
            '${position.latitude.toStringAsFixed(6)}, '
            '${position.longitude.toStringAsFixed(6)}';
      });
      showShopSnackBar(context, 'Current location added.');
    } catch (_) {
      showShopSnackBar(context, 'Unable to get current location.',
          isError: true);
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      showShopSnackBar(context, 'Please fix the highlighted fields.',
          isError: true);
      return;
    }

    setState(() => _isSaving = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_streetKey, _streetController.text.trim());
    await prefs.setString(_areaKey, _areaController.text.trim());
    await prefs.setString(_cityKey, _cityController.text.trim());
    await prefs.setString(_postalCodeKey, _postalCodeController.text.trim());
    await prefs.setString(_coordinatesKey, _coordinatesController.text.trim());

    if (!mounted) return;
    setState(() => _isSaving = false);
    showShopSnackBar(context, 'Shop address saved successfully.');
    Navigator.pop(context);
  }

  String? _requiredText(String? value, String label, {int minLength = 1}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter $label';
    if (text.length < minLength) return '$label is too short';
    return null;
  }

  String? _optionalPostalCode(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    if (!RegExp(r'^[0-9]{4,8}$').hasMatch(text)) {
      return 'Enter a valid postal code';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          const ShopFormHeader(
            title: 'Shop Address',
            subtitle: 'Manage pickup location',
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
                      title: 'Address Details',
                      icon: Icons.location_on_outlined,
                      children: [
                        ShopTextField(
                          controller: _streetController,
                          label: 'Street Address',
                          icon: Icons.home_outlined,
                          maxLines: 2,
                          validator: (value) => _requiredText(
                              value, 'street address',
                              minLength: 8),
                        ),
                        ShopTextField(
                          controller: _areaController,
                          label: 'Area / Locality',
                          icon: Icons.map_outlined,
                          validator: (value) =>
                              _requiredText(value, 'area', minLength: 3),
                        ),
                        ShopTextField(
                          controller: _cityController,
                          label: 'City',
                          icon: Icons.location_city_outlined,
                          validator: (value) =>
                              _requiredText(value, 'city', minLength: 2),
                        ),
                        ShopTextField(
                          controller: _postalCodeController,
                          label: 'Postal Code (Optional)',
                          icon: Icons.markunread_mailbox_outlined,
                          keyboardType: TextInputType.number,
                          validator: _optionalPostalCode,
                        ),
                        ShopTextField(
                          controller: _coordinatesController,
                          label: 'Coordinates (Optional)',
                          icon: Icons.my_location_outlined,
                          validator: (_) => null,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _isLocating ? null : _useCurrentLocation,
                            icon: _isLocating
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: SellerColors.primary,
                                    ),
                                  )
                                : const Icon(Icons.my_location_outlined),
                            label: Text(
                              _isLocating
                                  ? 'Getting Location...'
                                  : 'Use Current Location',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: SellerColors.primary,
                              side:
                                  const BorderSide(color: SellerColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ShopSaveButton(
                      label: 'Save Address',
                      isLoading: _isSaving,
                      onPressed: _saveAddress,
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
}
