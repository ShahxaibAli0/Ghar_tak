import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class ShopHelpCenterScreen extends StatefulWidget {
  const ShopHelpCenterScreen({super.key});

  @override
  State<ShopHelpCenterScreen> createState() =>
      _ShopHelpCenterScreenState();
}

class _ShopHelpCenterScreenState
    extends State<ShopHelpCenterScreen> {
  String _searchQuery = '';
  int? _expandedIndex;

  final List<Map<String, String>> faqs = [
    {
      'q': 'How do I publish a product?',
      'a':
          'Go to Tools tab, tap "Add New Product", fill in all details and tap "Publish Product". It will appear on user side immediately.',
    },
    {
      'q': 'How do I accept an order?',
      'a':
          'Go to Tools tab, open "All Orders", find pending orders and tap "Accept". Customer will be notified.',
    },
    {
      'q': 'When will I receive my payment?',
      'a':
          'Payments are processed after order delivery confirmation. Funds appear in your wallet within 24-48 hours.',
    },
    {
      'q': 'How do I withdraw my earnings?',
      'a':
          'Go to Tools tab, tap "Wallet", then tap "Withdraw Funds". Enter the amount and your bank account details.',
    },
    {
      'q': 'How do I update my product?',
      'a':
          'Go to Tools, open "My Products", tap the edit icon on any product and update the details.',
    },
    {
      'q': 'What if a customer complains?',
      'a':
          'Check the Chats section for customer messages. For refund requests, contact our support team.',
    },
    {
      'q': 'How do I improve my shop rating?',
      'a':
          'Deliver on time, maintain product quality, and respond to customer reviews promptly.',
    },
    {
      'q': 'Can I sell in multiple categories?',
      'a':
          'Currently each shop is assigned one category. Contact support to request a category change.',
    },
  ];

  List<Map<String, String>> get _filtered {
    if (_searchQuery.isEmpty) return faqs;
    return faqs
        .where((f) =>
            f['q']!.toLowerCase().contains(
                _searchQuery.toLowerCase()) ||
            f['a']!.toLowerCase().contains(
                _searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Column(
        children: [
          _buildHeader(context),
          _buildSearchBar(),
          Expanded(child: _buildFaqList()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          20, 55, 20, 24),
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
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text('Help Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Text('Frequently asked questions',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          16, 14, 16, 6),
      child: TextField(
        onChanged: (val) =>
            setState(() => _searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Search questions...',
          hintStyle: const TextStyle(
              color: SellerColors.subText,
              fontSize: 13),
          prefixIcon: const Icon(Icons.search,
              color: SellerColors.primary, size: 20),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
                color: SellerColors.primary,
                width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildFaqList() {
    final list = _filtered;

    if (list.isEmpty) {
      return const Center(
        child: Text('No results found',
            style: TextStyle(
                color: SellerColors.subText,
                fontSize: 14)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
          16, 8, 16, 24),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final faq = list[index];
        final bool expanded =
            _expandedIndex == index;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              onExpansionChanged: (val) =>
                  setState(() => _expandedIndex =
                      val ? index : null),
              initiallyExpanded: expanded,
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: SellerColors.primary
                      .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.question_mark_rounded,
                  color: SellerColors.primary,
                  size: 18,
                ),
              ),
              title: Text(
                faq['q']!,
                style: TextStyle(
                  fontWeight: expanded
                      ? FontWeight.bold
                      : FontWeight.w500,
                  fontSize: 13,
                  color: SellerColors.darkText,
                ),
              ),
              trailing: Icon(
                expanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: SellerColors.primary,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      16, 0, 16, 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: SellerColors.lightGreen,
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                    child: Text(
                      faq['a']!,
                      style: const TextStyle(
                        color: SellerColors.darkText,
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}