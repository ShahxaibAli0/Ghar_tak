import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';
import '../notifications/seller_notifications_screen.dart';


class SellerDashboardScreen extends StatelessWidget {
  final Function(int)? onTabSwitch;
  const SellerDashboardScreen({super.key, this.onTabSwitch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: CustomScrollView(
        slivers: [
          // ── Header ──
          SliverToBoxAdapter(child: _buildHeader(context)),

          // ── Quick Actions (FIXED horizontal scroll) ──
          // ── Body Content ──
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildStatsCards(),
                const SizedBox(height: 16),
                _buildOrderStatus(),
                const SizedBox(height: 16),
                _buildRecentOrders(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════
  // HEADER
  // ═══════════════════════════════
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
          // Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seller Center',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
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
                  // Notification Bell
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SellerNotificationsScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                          Positioned(
                            right: -1,
                            top: -1,
                            child: Container(
                              width: 9,
                              height: 9,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: SellerColors.primary,
                                    width: 1.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Avatar
                  CircleAvatar(
                    radius: 21,
                    backgroundColor:
                        Colors.white.withOpacity(0.22),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Earnings Row
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: Colors.white.withOpacity(0.25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _headerStat('Total Earnings', 'Rs. 45,200'),
                _vLine(),
                _headerStat('This Month', 'Rs. 12,800'),
                _vLine(),
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
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.72),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _vLine() {
    return Container(
      height: 32,
      width: 1,
      color: Colors.white.withOpacity(0.28),
    );
  }

  // ═══════════════════════════════
  // QUICK ACTIONS — Horizontal Scroll
  // ═══════════════════════════════
  // ═══════════════════════════════
  // STATS CARDS
  // ═══════════════════════════════
  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.3,
        children: [
          _statCard('Total Orders', '248',
              Icons.receipt_long, Colors.blue, '+12 today'),
          _statCard('Total Products', '56',
              Icons.inventory_2, Colors.orange,
              '4 out of stock'),
          _statCard('Delivered', '210',
              Icons.check_circle, Colors.green,
              '85% success'),
          _statCard('Cancelled', '14',
              Icons.cancel, Colors.red, '5.6% rate'),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value,
      IconData icon, Color color, String sub) {
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

  // ═══════════════════════════════
  // ORDER STATUS
  // ═══════════════════════════════
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
                fontSize: 14,
                color: SellerColors.darkText,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statusItem('Pending', '18',
                    Colors.orange, Icons.hourglass_top),
                _arrow(),
                _statusItem('Processing', '24',
                    Colors.blue, Icons.sync),
                _arrow(),
                _statusItem('Shipped', '32',
                    Colors.purple, Icons.local_shipping),
                _arrow(),
                _statusItem('Delivered', '210',
                    Colors.green, Icons.check_circle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusItem(String label, String count,
      Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(height: 5),
        Text(
          count,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 15,
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

  Widget _arrow() {
    return const Icon(
      Icons.arrow_forward_ios,
      color: Color(0xFFCCCCCC),
      size: 11,
    );
  }

  // ═══════════════════════════════
  // RECENT ORDERS
  // ═══════════════════════════════
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
                    fontSize: 14,
                    color: SellerColors.darkText,
                  ),
                ),
                GestureDetector(
                  onTap: () => onTabSwitch?.call(2),
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: SellerColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
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
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: SellerColors.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.shopping_bag,
              color: SellerColors.primary,
              size: 18,
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
}
