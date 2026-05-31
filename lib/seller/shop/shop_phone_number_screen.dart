import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class ShopPhoneNumberScreen extends StatefulWidget {
  const ShopPhoneNumberScreen({super.key});

  @override
  State<ShopPhoneNumberScreen> createState() =>
      _ShopPhoneNumberScreenState();
}

class _ShopPhoneNumberScreenState
    extends State<ShopPhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController =
      TextEditingController(text: '0300-1234567');
  final _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
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
                    const SizedBox(height: 8),

                    // Current number display
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current Number',
                            style: TextStyle(
                              color: SellerColors.subText,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.phone,
                                  color:
                                      SellerColors.primary,
                                  size: 18),
                              const SizedBox(width: 8),
                              Text(
                                _phoneController.text,
                                style: const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 16,
                                  color:
                                      SellerColors.darkText,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green
                                      .withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius
                                          .circular(20),
                                ),
                                child: const Text(
                                  'Verified',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // New number input
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'New Phone Number',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: SellerColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType:
                                TextInputType.phone,
                            decoration: _inputDeco(
                              'Enter new number',
                              Icons.phone_outlined,
                            ),
                            validator: (val) =>
                                val == null || val.isEmpty
                                    ? 'Enter phone number'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          if (_otpSent) ...[
                            TextFormField(
                              controller: _otpController,
                              keyboardType:
                                  TextInputType.number,
                              maxLength: 6,
                              decoration: _inputDeco(
                                'Enter OTP code',
                                Icons.verified_outlined,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  'Did not receive OTP? ',
                                  style: TextStyle(
                                    color:
                                        SellerColors.subText,
                                    fontSize: 12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Resend',
                                    style: TextStyle(
                                      color: SellerColors
                                          .primary,
                                      fontWeight:
                                          FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    SellerColors.primary,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          12),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!
                                    .validate()) {
                                  if (!_otpSent) {
                                    setState(
                                        () => _otpSent =
                                            true);
                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'OTP sent to your number'),
                                        backgroundColor:
                                            SellerColors
                                                .primary,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: const Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .check_circle,
                                              color: Colors
                                                  .white,
                                            ),
                                            SizedBox(
                                                width: 10),
                                            Text(
                                                'Phone number updated!'),
                                          ],
                                        ),
                                        backgroundColor:
                                            SellerColors
                                                .primary,
                                        behavior:
                                            SnackBarBehavior
                                                .floating,
                                        shape:
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                                      12),
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text(
                                _otpSent
                                    ? 'Verify & Update'
                                    : 'Send OTP',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          20, 55, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF007A3D),
            Color(0xFF00A651),
            Color(0xFF2ECC7A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
                borderRadius:
                    BorderRadius.circular(10),
              ),
              child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18),
            ),
          ),
          const SizedBox(width: 14),
          const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text('Phone Number',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Update contact number',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDeco(
      String label, IconData icon) {
    return InputDecoration(
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
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
            color: SellerColors.primary, width: 2),
      ),
      labelStyle: const TextStyle(
          color: SellerColors.subText, fontSize: 13),
    );
  }
}