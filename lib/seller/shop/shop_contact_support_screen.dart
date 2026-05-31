import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class ShopContactSupportScreen extends StatefulWidget {
  const ShopContactSupportScreen({super.key});

  @override
  State<ShopContactSupportScreen> createState() =>
      _ShopContactSupportScreenState();
}

class _ShopContactSupportScreenState
    extends State<ShopContactSupportScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedIssue;
  final _msgController = TextEditingController();

  final List<String> issues = [
    'Order related issue',
    'Payment / Withdrawal issue',
    'Product listing issue',
    'Account access issue',
    'Technical problem',
    'Other',
  ];

  @override
  void dispose() {
    _msgController.dispose();
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
                  _buildContactOptions(),
                  const SizedBox(height: 16),
                  _buildMessageForm(context),
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
              Text('Contact Support',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text('We are here to help you',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactOptions() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Contact',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: SellerColors.darkText,
              )),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _contactOption(
                  Icons.phone_outlined,
                  'Call Us',
                  '0800-12345',
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _contactOption(
                  Icons.chat_outlined,
                  'Live Chat',
                  'Available 9AM-9PM',
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _contactOption(
                  Icons.email_outlined,
                  'Email',
                  'support@gharak.com',
                  Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactOption(IconData icon, String title,
      String sub, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              )),
          const SizedBox(height: 2),
          Text(sub,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: SellerColors.subText,
                fontSize: 9,
              )),
        ],
      ),
    );
  }

  Widget _buildMessageForm(BuildContext context) {
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
                const Text('Send a Message',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: SellerColors.darkText,
                    )),
              ],
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: selectedIssue,
              decoration: _inputDeco(
                'Select Issue Type',
                Icons.help_outline,
              ),
              dropdownColor: Colors.white,
              borderRadius:
                  BorderRadius.circular(12),
              isExpanded: true,
              items: issues
                  .map((i) => DropdownMenuItem(
                      value: i, child: Text(i)))
                  .toList(),
              onChanged: (val) => setState(
                  () => selectedIssue = val),
              validator: (val) => val == null
                  ? 'Please select issue type'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _msgController,
              maxLines: 5,
              decoration: _inputDeco(
                'Describe your issue...',
                Icons.message_outlined,
              ),
              validator: (val) =>
                  val == null || val.isEmpty
                      ? 'Please describe your issue'
                      : null,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: const Row(children: [
                          Icon(Icons.check_circle,
                              color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                              'Message sent! We will reply within 24 hours.'),
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
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.send_outlined,
                    color: Colors.white, size: 18),
                label: const Text('Send Message',
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