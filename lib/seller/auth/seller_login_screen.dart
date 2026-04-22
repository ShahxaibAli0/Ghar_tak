import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../widgets/seller_colors.dart';
import 'seller_register_screen.dart';

class SellerLoginScreen extends StatefulWidget {
  const SellerLoginScreen({super.key});

  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
  static const _passwordKey = 'seller_password';

  final _formKey = GlobalKey<FormState>();
  final _secureStorage = const FlutterSecureStorage();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoggingIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoggingIn = true);

    try {
      final savedPassword = await _secureStorage.read(key: _passwordKey);
      if (savedPassword != null &&
          _passwordController.text.trim() != savedPassword) {
        if (!mounted) return;
        setState(() => _isLoggingIn = false);
        _showSnackBar('Invalid password. Please try again.', isError: true);
        return;
      }

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/seller-home');
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoggingIn = false);
      _showSnackBar('Unable to login. Please try again.', isError: true);
    }
  }

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
              padding: const EdgeInsets.fromLTRB(24, 70, 24, 40),
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
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.storefront,
                        color: Colors.white, size: 54),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'GHAR TAK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Seller Center',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 15,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // ═══ Login Form ═══
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome Back! ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: SellerColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Login to manage your store',
                      style:
                          TextStyle(color: SellerColors.subText, fontSize: 14),
                    ),
                    const SizedBox(height: 30),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                          'Email Address', Icons.email_outlined),
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter email' : null,
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration:
                          _inputDecoration('Password', Icons.lock_outline)
                              .copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: SellerColors.primary,
                          ),
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter password' : null,
                    ),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: SellerColors.primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ── Login Button ──
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
                              SellerColors.primary.withValues(alpha: 0.4),
                        ),
                        onPressed: _isLoggingIn ? null : _login,
                        child: _isLoggingIn
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.4,
                                ),
                              )
                            : const Text(
                                'Login to Seller Center',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Divider ──
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(color: Color(0xFFDDDDDD))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('OR',
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 13)),
                        ),
                        const Expanded(
                            child: Divider(color: Color(0xFFDDDDDD))),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ── New Seller ──
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: SellerColors.primary, width: 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SellerRegisterScreen()),
                        ),
                        child: const Text(
                          'Create New Seller Account',
                          style: TextStyle(
                            fontSize: 15,
                            color: SellerColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
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
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SellerColors.primary, width: 2),
      ),
      labelStyle: const TextStyle(color: SellerColors.subText, fontSize: 14),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
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
}
