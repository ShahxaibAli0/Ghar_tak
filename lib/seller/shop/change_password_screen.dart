import 'package:flutter/material.dart';

import '../auth/seller_auth_store.dart';
import '../widgets/seller_colors.dart';
import 'shop_form_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isSaving = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _savePassword() async {
    if (!_formKey.currentState!.validate()) {
      showShopSnackBar(context, 'Please fix the highlighted fields.',
          isError: true);
      return;
    }

    setState(() => _isSaving = true);

    final error = await SellerAuthStore.changePassword(
      currentPassword: _currentPasswordController.text.trim(),
      newPassword: _newPasswordController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    setState(() => _isSaving = false);
    if (error != null) {
      showShopSnackBar(context, error, isError: true);
      return;
    }

    showShopSnackBar(context, 'Password changed successfully.');
    Navigator.pop(context);
  }

  String? _currentPasswordValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter current password';
    return null;
  }

  String? _newPasswordValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter new password';
    if (text.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[A-Za-z]').hasMatch(text) ||
        !RegExp(r'[0-9]').hasMatch(text)) {
      return 'Use letters and numbers';
    }
    if (text == _currentPasswordController.text.trim()) {
      return 'New password must be different';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please confirm password';
    if (text != _newPasswordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  Widget _visibilityButton(bool obscure, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        obscure ? Icons.visibility_off : Icons.visibility,
        color: SellerColors.primary,
      ),
      tooltip: obscure ? 'Show password' : 'Hide password',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          const ShopFormHeader(
            title: 'Change Password',
            subtitle: 'Update your account password',
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
                      title: 'Password Details',
                      icon: Icons.lock_outline,
                      children: [
                        ShopTextField(
                          controller: _currentPasswordController,
                          label: 'Current Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscureCurrent,
                          suffixIcon: _visibilityButton(
                            _obscureCurrent,
                            () => setState(
                                () => _obscureCurrent = !_obscureCurrent),
                          ),
                          validator: _currentPasswordValidator,
                        ),
                        ShopTextField(
                          controller: _newPasswordController,
                          label: 'New Password',
                          icon: Icons.password_outlined,
                          obscureText: _obscureNew,
                          suffixIcon: _visibilityButton(
                            _obscureNew,
                            () => setState(() => _obscureNew = !_obscureNew),
                          ),
                          validator: _newPasswordValidator,
                        ),
                        ShopTextField(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          icon: Icons.verified_user_outlined,
                          obscureText: _obscureConfirm,
                          suffixIcon: _visibilityButton(
                            _obscureConfirm,
                            () => setState(
                                () => _obscureConfirm = !_obscureConfirm),
                          ),
                          validator: _confirmPasswordValidator,
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Use at least 8 characters with letters and numbers.',
                          style: TextStyle(
                            color: SellerColors.subText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ShopSaveButton(
                      label: 'Save Password',
                      isLoading: _isSaving,
                      onPressed: _savePassword,
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
