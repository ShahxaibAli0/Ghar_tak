import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class SellerReviewsScreen extends StatefulWidget {
  const SellerReviewsScreen({super.key});

  @override
  State<SellerReviewsScreen> createState() =>
      _SellerReviewsScreenState();
}

class _SellerReviewsScreenState extends State<SellerReviewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Ali Hassan',
      'product': 'LED Bulb 12W',
      'rating': 5,
      'comment':
          'Bohat acha product hai! Quality bilkul darust hai aur delivery bhi fast thi. Zaroor recommend karunga.',
      'date': '03 Apr 2026',
      'avatar': 'A',
      'replied': false,
      'reply': '',
    },
    {
      'name': 'Sara Khan',
      'product': 'Basmati Rice 5kg',
      'rating': 4,
      'comment':
          'Rice ki quality achi hai lekin packaging thodi weak thi. Overall experience acha raha.',
      'date': '02 Apr 2026',
      'avatar': 'S',
      'replied': true,
      'reply': 'Shukriya Sara ji! Packaging improve kar denge.',
    },
    {
      'name': 'Usman Tariq',
      'product': 'PVC Pipe 1 inch',
      'rating': 3,
      'comment':
          'Product theek hai lekin delivery mein 3 din lag gaye. Thodi jaldi honi chahiye thi.',
      'date': '01 Apr 2026',
      'avatar': 'U',
      'replied': false,
      'reply': '',
    },
    {
      'name': 'Ayesha Noor',
      'product': 'Panadol 10 Tabs',
      'rating': 5,
      'comment':
          'Original product mila. Bilkul genuine. Packaging bhi sealed thi. Bohat khush hun.',
      'date': '31 Mar 2026',
      'avatar': 'A',
      'replied': true,
      'reply': 'Bohot shukriya Ayesha ji! Hamesha ayen.',
    },
    {
      'name': 'Bilal Raza',
      'product': 'Wood Screw Set',
      'rating': 2,
      'comment':
          'Quality itni achi nahi thi jitni expect ki thi. Screws thodi weak hain.',
      'date': '30 Mar 2026',
      'avatar': 'B',
      'replied': false,
      'reply': '',
    },
    {
      'name': 'Hira Malik',
      'product': 'LED Bulb 12W',
      'rating': 5,
      'comment':
          'Zabardast! Ghar mein 5 bulb lagaye hain sab chal rahe hain. Price bhi reasonable hai.',
      'date': '28 Mar 2026',
      'avatar': 'H',
      'replied': false,
      'reply': '',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ── Rating average ──
  double get _avgRating {
    if (reviews.isEmpty) return 0;
    final total =
        reviews.fold(0, (sum, r) => sum + (r['rating'] as int));
    return total / reviews.length;
  }

  // ── Star count ──
  int _starCount(int star) =>
      reviews.where((r) => r['rating'] == star).length;

  // ── Filtered list ──
  List<Map<String, dynamic>> get _filtered {
    List<Map<String, dynamic>> list = reviews;

    if (_tabController.index == 1) {
      list = list.where((r) => r['replied'] == false).toList();
    } else if (_tabController.index == 2) {
      list = list.where((r) => r['replied'] == true).toList();
    }

    if (_searchQuery.isNotEmpty) {
      list = list
          .where((r) =>
              r['name']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              r['product']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          _buildHeader(context),
          _buildRatingSummary(),
          _buildSearchBar(),
          _buildTabBar(),
          Expanded(child: _buildReviewList()),
        ],
      ),
    );
  }

  // ═══ Header ═══
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer Reviews',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'What customers say about you',
                style:
                    TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${reviews.length} Reviews',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Rating Summary Card ═══
  Widget _buildRatingSummary() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Big Rating Number ──
            Column(
              children: [
                Text(
                  _avgRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: SellerColors.darkText,
                  ),
                ),
                _buildStars(_avgRating.round(), size: 18),
                const SizedBox(height: 4),
                Text(
                  '${reviews.length} reviews',
                  style: const TextStyle(
                    color: SellerColors.subText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 20),
            const VerticalDivider(width: 1),
            const SizedBox(width: 20),

            // ── Star Breakdown ──
            Expanded(
              child: Column(
                children: [5, 4, 3, 2, 1].map((star) {
                  final count = _starCount(star);
                  final percent = reviews.isEmpty
                      ? 0.0
                      : count / reviews.length;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Text(
                          '$star',
                          style: const TextStyle(
                            fontSize: 12,
                            color: SellerColors.subText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.star,
                            color: Colors.amber, size: 12),
                        const SizedBox(width: 6),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: percent,
                              backgroundColor: Colors.grey[200],
                              color: Colors.amber,
                              minHeight: 7,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$count',
                          style: const TextStyle(
                            fontSize: 11,
                            color: SellerColors.subText,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══ Search Bar ═══
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Search by name or product...',
          hintStyle: const TextStyle(
              color: SellerColors.subText, fontSize: 13),
          prefixIcon:
              const Icon(Icons.search, color: SellerColors.primary),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear,
                      color: SellerColors.subText),
                  onPressed: () =>
                      setState(() => _searchQuery = ''),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
                color: SellerColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }

  // ═══ Tab Bar ═══
  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: _tabController,
          onTap: (_) => setState(() {}),
          indicator: BoxDecoration(
            color: SellerColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: SellerColors.subText,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending Reply'),
            Tab(text: 'Replied'),
          ],
        ),
      ),
    );
  }

  // ═══ Review List ═══
  Widget _buildReviewList() {
    final list = _filtered;

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.reviews_outlined,
                size: 64, color: Colors.grey[300]),
            const SizedBox(height: 12),
            const Text(
              'No reviews found',
              style: TextStyle(
                  color: SellerColors.subText, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: list.length,
      itemBuilder: (context, index) =>
          _reviewCard(context, list[index]),
    );
  }

  // ═══ Review Card ═══
  Widget _reviewCard(
      BuildContext context, Map<String, dynamic> review) {
    final int rating = review['rating'] as int;
    final bool replied = review['replied'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Row ──
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 22,
                  backgroundColor:
                      SellerColors.primary.withOpacity(0.15),
                  child: Text(
                    review['avatar'],
                    style: const TextStyle(
                      color: SellerColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Name + Product
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: SellerColors.darkText,
                        ),
                      ),
                      Text(
                        review['product'],
                        style: const TextStyle(
                          color: SellerColors.subText,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                // Date
                Text(
                  review['date'],
                  style: const TextStyle(
                    color: SellerColors.subText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Stars + Badge ──
            Row(
              children: [
                _buildStars(rating),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _ratingColor(rating).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _ratingLabel(rating),
                    style: TextStyle(
                      color: _ratingColor(rating),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                // Replied badge
                if (replied)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: Colors.green, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'Replied',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Comment ──
            Text(
              review['comment'],
              style: const TextStyle(
                color: SellerColors.darkText,
                fontSize: 13,
                height: 1.5,
              ),
            ),

            // ── Seller Reply ──
            if (replied && review['reply'] != '') ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: SellerColors.lightGreen,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: SellerColors.primary.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.store,
                        color: SellerColors.primary, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Reply',
                            style: TextStyle(
                              color: SellerColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            review['reply'],
                            style: const TextStyle(
                              color: SellerColors.darkText,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 12),

            // ── Reply Button ──
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _replySheet(context, review),
                icon: Icon(
                  replied
                      ? Icons.edit_outlined
                      : Icons.reply_outlined,
                  size: 16,
                  color: SellerColors.primary,
                ),
                label: Text(
                  replied ? 'Edit Reply' : 'Reply to Review',
                  style: const TextStyle(
                    color: SellerColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      color: SellerColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══ Reply Bottom Sheet ═══
  void _replySheet(
      BuildContext context, Map<String, dynamic> review) {
    final controller =
        TextEditingController(text: review['reply'] ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Title
              const Text(
                'Reply to Review',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: SellerColors.darkText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${review['name']} — ${review['product']}',
                style: const TextStyle(
                  color: SellerColors.subText,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),

              // Customer comment preview
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  review['comment'],
                  style: const TextStyle(
                    color: SellerColors.subText,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Reply text field
              TextField(
                controller: controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Apna reply likhein...',
                  hintStyle: const TextStyle(
                      color: SellerColors.subText, fontSize: 13),
                  filled: true,
                  fillColor: SellerColors.lightGreen,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: SellerColors.primary, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Send Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SellerColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 3,
                  ),
                  onPressed: () {
                    setState(() {
                      review['replied'] = true;
                      review['reply'] = controller.text;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Text('Reply submitted!'),
                          ],
                        ),
                        backgroundColor: SellerColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send,
                      color: Colors.white, size: 18),
                  label: const Text(
                    'Send Reply',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // ═══ Stars Widget ═══
  Widget _buildStars(int rating, {double size = 15}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Icon(
          i < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: size,
        );
      }),
    );
  }

  // ═══ Rating Label ═══
  String _ratingLabel(int rating) {
    switch (rating) {
      case 5: return 'Excellent';
      case 4: return 'Good';
      case 3: return 'Average';
      case 2: return 'Poor';
      case 1: return 'Terrible';
      default: return '';
    }
  }

  // ═══ Rating Color ═══
  Color _ratingColor(int rating) {
    switch (rating) {
      case 5: return Colors.green;
      case 4: return Colors.lightGreen;
      case 3: return Colors.orange;
      case 2: return Colors.deepOrange;
      case 1: return Colors.red;
      default: return Colors.grey;
    }
  }
}