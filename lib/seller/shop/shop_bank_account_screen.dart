import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class ShopBankAccountScreen extends StatefulWidget {
  const ShopBankAccountScreen({super.key});

  @override
  State<ShopBankAccountScreen> createState() =>
      _ShopBankAccountScreenState();
}

class _ShopBankAccountScreenState
    extends State<ShopBankAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedBank;

  final _accountTitleController =
      TextEditingController();
  final _accountNumberController =
      TextEditingController();
  final _ibanController = TextEditingController();

  final List<String> banks = [
    'HBL - Habib Bank Limited',
    'UBL - United Bank Limited',
    'MCB - Muslim Commercial Bank',
    'ABL - Allied Bank Limited',
    'Meezan Bank',
    'Bank Alfalah',
    'Standard Chartered',
    'Easypaisa',
    'JazzCash',
    'SadaPay',
    'NayaPay',
  ];

  bool _hasSavedAccount = false;

  @override
  void dispose() {
    _accountTitleController.dispose();
    _accountNumberController.dispose();
    _ibanController.dispose();
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
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Saved account card
                  if (_hasSavedAccount)
                    _buildSavedCard(),

                  if (_hasSavedAccount)
                    const SizedBox(height: 14),

                  // Add/Update form
                  _buildFormCard(context),

                  const SizedBox(height: 14),
                  _buildSecureNote(),
                ],
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
              Text('Bank Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Withdraw your earnings here',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavedCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text('Saved Account',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.65),
                    fontSize: 12,
                  )),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified,
                        color: Colors.green, size: 12),
                    SizedBox(width: 4),
                    Text('Verified',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Ahmed Khan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 4),
          Text('HBL - Habib Bank Limited',
              style: TextStyle(
                color: Colors.white.withOpacity(0.65),
                fontSize: 12,
              )),
          const SizedBox(height: 8),
          Text('**** **** **** 4521',
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 14,
                letterSpacing: 2,
              )),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 16,
                  decoration: BoxDecoration(
                    color: SellerColors.primary,
                    borderRadius:
                        BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Add Bank Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: SellerColors.darkText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Bank dropdown
            DropdownButtonFormField<String>(
              value: selectedBank,
              decoration: _inputDeco(
                'Select Bank',
                Icons.account_balance_outlined,
              ),
              dropdownColor: Colors.white,
              borderRadius:
                  BorderRadius.circular(12),
              isExpanded: true,
              items: banks
                  .map((b) => DropdownMenuItem(
                      value: b, child: Text(b)))
                  .toList(),
              onChanged: (val) =>
                  setState(() => selectedBank = val),
              validator: (val) => val == null
                  ? 'Please select bank'
                  : null,
            ),
            const SizedBox(height: 12),

            _field('Account Title',
                Icons.person_outlined,
                _accountTitleController),
            const SizedBox(height: 12),

            _field('Account Number',
                Icons.credit_card_outlined,
                _accountNumberController,
                keyboard: TextInputType.number),
            const SizedBox(height: 12),

            _field('IBAN (Optional)',
                Icons.numbers_outlined,
                _ibanController,
                isRequired: false),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      SellerColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () {
                  if (_formKey.currentState!
                      .validate()) {
                    setState(
                        () => _hasSavedAccount = true);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: const Row(children: [
                          Icon(Icons.check_circle,
                              color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                              'Bank account saved!'),
                        ]),
                        backgroundColor:
                            SellerColors.primary,
                        behavior:
                            SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12)),
                      ),
                    );
                  }
                },
                child: const Text('Save Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecureNote() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Colors.green.withOpacity(0.2)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined,
              color: Colors.green, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Your bank details are encrypted and secure. We never share your information with third parties.',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    String label,
    IconData icon,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    bool isRequired = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: _inputDeco(label, icon),
      validator: isRequired
          ? (val) => val == null || val.isEmpty
              ? 'Enter $label'
              : null
          : null,
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