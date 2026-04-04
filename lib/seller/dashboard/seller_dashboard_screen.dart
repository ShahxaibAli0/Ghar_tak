import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';
import '../products/add_product_screen.dart';
import '../notifications/seller_notifications_screen.dart';
import '../reviews/seller_reviews_screen.dart';
import '../reports/seller_reports_screen.dart';

class SellerDashboardScreen extends StatelessWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildStatsCards(),
            const SizedBox(height: 20),
            _buildOrderStatus(),
            const SizedBox(height: 20),
            _buildRecentOrders(),
            const SizedBox(height: 20),
            _buildQuickActions(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ═══ Header ═══
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 55, 20, 24),
      decoration: const BoxDecoration(
        color: SellerColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning! 👋',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Ahmed Electronics',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // ── Notification Bell ──
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SellerNotificationsScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 9,
                              height: 9,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // ── Avatar ──
                  CircleAvatar(
                    radius: 22,
                    backgroundColor:
                        Colors.white.withOpacity(0.25),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Earnings Card ──
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _headerStat('Total Earnings', 'Rs. 45,200'),
                _dividerLine(),
                _headerStat('This Month', 'Rs. 12,800'),
                _dividerLine(),
                _headerStat('Pending', 'Rs. 3,400'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _dividerLine() {
    return Container(
      height: 36,
      width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }

  // ═══ Stats Cards ═══
  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.6,
        children: [
          _statCard('Total Orders', '248',
              Icons.receipt_long, Colors.blue, '+12 today'),
          _statCard('Total Products', '56',
              Icons.inventory_2, Colors.orange, '4 out of stock'),
          _statCard('Delivered', '210',
              Icons.check_circle, Colors.green, '85% success'),
          _statCard('Cancelled', '14',
              Icons.cancel, Colors.red, '5.6% rate'),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon,
      Color color, String sub) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: SellerColors.subText,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                sub,
                style: const TextStyle(
                  color: SellerColors.subText,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══ Order Status ═══
  Widget _buildOrderStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Status',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: SellerColors.darkText,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _orderStatusItem('Pending', '18',
                    Colors.orange, Icons.hourglass_top),
                _arrowIcon(),
                _orderStatusItem('Processing', '24',
                    Colors.blue, Icons.sync),
                _arrowIcon(),
                _orderStatusItem('Shipped', '32',
                    Colors.purple, Icons.local_shipping),
                _arrowIcon(),
                _orderStatusItem('Delivered', '210',
                    Colors.green, Icons.check_circle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderStatusItem(
      String label, String count, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 6),
        Text(
          count,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: SellerColors.subText,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _arrowIcon() {
    return const Icon(
      Icons.arrow_forward_ios,
      color: Color(0xFFCCCCCC),
      size: 12,
    );
  }

  // ═══ Recent Orders ═══
  Widget _buildRecentOrders() {
    final orders = [
      {
        'id': '#ORD-1023',
        'name': 'Ali Hassan',
        'amount': 'Rs. 1,200',
        'status': 'Pending',
        'color': Colors.orange,
      },
      {
        'id': '#ORD-1022',
        'name': 'Sara Khan',
        'amount': 'Rs. 850',
        'status': 'Delivered',
        'color': Colors.green,
      },
      {
        'id': '#ORD-1021',
        'name': 'Usman Tariq',
        'amount': 'Rs. 3,400',
        'status': 'Processing',
        'color': Colors.blue,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: SellerColors.darkText,
                  ),
                ),
                const Text(
                  'See All',
                  style: TextStyle(
                    color: SellerColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...orders.map((order) => _orderTile(order)),
          ],
        ),
      ),
    );
  }

  Widget _orderTile(Map order) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: SellerColors.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.shopping_bag,
              color: SellerColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: SellerColors.darkText,
                  ),
                ),
                Text(
                  order['id'],
                  style: const TextStyle(
                    color: SellerColors.subText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                order['amount'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: SellerColors.darkText,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (order['color'] as Color)
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order['status'],
                  style: TextStyle(
                    color: order['color'] as Color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══ Quick Actions ═══
  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: SellerColors.darkText,
            ),
          ),
          const SizedBox(height: 12),

          // ── Row 1 ──
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  context,
                  'Add Product',
                  Icons.add_box_outlined,
                  SellerColors.primary,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddProductScreen(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _actionButton(
                  context,
                  'Notifications',
                  Icons.notifications_outlined,
                  Colors.blue,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const SellerNotificationsScreen(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _actionButton(
                  context,
                  'Reviews',
                  Icons.star_outline,
                  Colors.amber,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SellerReviewsScreen(),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Row 2 ──
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  context,
                  'Reports',
                  Icons.bar_chart_outlined,
                  Colors.teal,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const SellerReportsScreen(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _actionButton(
                  context,
                  'My Products',
                  Icons.inventory_2_outlined,
                  Colors.orange,
                  () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _actionButton(
                  context,
                  'Wallet',
                  Icons.account_balance_wallet_outlined,
                  Colors.green,
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context, String label,
      IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 7),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}