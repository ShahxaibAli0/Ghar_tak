import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';
import '../notifications/seller_notifications_screen.dart';
import '../orders/seller_orders_screen.dart';

class SellerHomeScreen extends StatelessWidget {
  final Function(int)? onTabSwitch;
  const SellerHomeScreen({super.key, this.onTabSwitch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: _buildHeader(context)),
          SliverToBoxAdapter(
              child: _buildOverviewCards()),
          SliverToBoxAdapter(
              child: _buildOrderPipeline(context)),
          SliverToBoxAdapter(
              child: _buildRecentOrders(context)),
          const SliverToBoxAdapter(
              child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  // ═══════════════════════════
  // HEADER — Soft Green Gradient
  // ═══════════════════════════
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 26),
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
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          // Top Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seller Center',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.78),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
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
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const
                            SellerNotificationsScreen(),
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.18),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white
                                  .withOpacity(0.3),
                            ),
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 21,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: Colors.red[400],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(
                                    0xFF00A651),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            Colors.white.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Colors.white.withOpacity(0.2),
                      child: const Icon(Icons.person,
                          color: Colors.white, size: 21),
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
                vertical: 14, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.13),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                _earningTile(
                    'Today', 'Rs. 4,300',
                    Icons.wb_sunny_outlined),
                _vLine(),
                _earningTile(
                    'This Month', 'Rs. 12,800',
                    Icons.calendar_month_outlined),
                _vLine(),
                _earningTile(
                    'Total', 'Rs. 45,200',
                    Icons.account_balance_wallet_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _earningTile(
      String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon,
            color: Colors.white.withOpacity(0.72),
            size: 14),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.68),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _vLine() {
    return Container(
      height: 34,
      width: 1,
      color: Colors.white.withOpacity(0.25),
    );
  }

  // ═══════════════════════════
  // OVERVIEW CARDS
  // ═══════════════════════════
  Widget _buildOverviewCards() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: SellerColors.darkText,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.65,
            children: [
              _statCard('Total Orders', '248',
                  Icons.receipt_long,
                  Colors.blue, '+12 today'),
              _statCard('Delivered', '210',
                  Icons.check_circle,
                  Colors.green, '85% success'),
              _statCard('Pending', '18',
                  Icons.hourglass_top,
                  Colors.orange, 'Action needed'),
              _statCard('Cancelled', '14',
                  Icons.cancel,
                  Colors.red, '5.6% rate'),
            ],
          ),
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
            color: Colors.black.withOpacity(0.04),
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
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                    color: SellerColors.subText,
                    fontSize: 11,
                  )),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                child:
                    Icon(icon, color: color, size: 15),
              ),
            ],
          ),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
              Text(sub,
                  style: const TextStyle(
                    color: SellerColors.subText,
                    fontSize: 10,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════
  // ORDER PIPELINE
  // ═══════════════════════════
  Widget _buildOrderPipeline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Container(
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
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text('Order Pipeline',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: SellerColors.darkText,
                    )),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const SellerOrdersScreen(),
                    ),
                  ),
                  child: const Text('View All',
                      style: TextStyle(
                        color: SellerColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                _dot('Pending', '18', Colors.orange,
                    Icons.hourglass_top),
                _arrow(),
                _dot('Processing', '24', Colors.blue,
                    Icons.sync),
                _arrow(),
                _dot('Shipped', '32', Colors.purple,
                    Icons.local_shipping),
                _arrow(),
                _dot('Delivered', '210', Colors.green,
                    Icons.check_circle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot(String label, String count,
      Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 17),
        ),
        const SizedBox(height: 4),
        Text(count,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            )),
        Text(label,
            style: const TextStyle(
              color: SellerColors.subText,
              fontSize: 10,
            )),
      ],
    );
  }

  Widget _arrow() {
    return const Icon(Icons.arrow_forward_ios,
        color: Color(0xFFCCCCCC), size: 10);
  }

  // ═══════════════════════════
  // RECENT ORDERS
  // ═══════════════════════════
  Widget _buildRecentOrders(BuildContext context) {
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
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Container(
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
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Orders',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: SellerColors.darkText,
                    )),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const SellerOrdersScreen(),
                    ),
                  ),
                  child: const Text('See All',
                      style: TextStyle(
                        color: SellerColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...orders.map((o) => _orderRow(o)),
          ],
        ),
      ),
    );
  }

  Widget _orderRow(Map order) {
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
            child: const Icon(Icons.shopping_bag,
                color: SellerColors.primary, size: 17),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(order['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: SellerColors.darkText,
                    )),
                Text(order['id'],
                    style: const TextStyle(
                      color: SellerColors.subText,
                      fontSize: 11,
                    )),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(order['amount'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: SellerColors.darkText,
                  )),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (order['color'] as Color)
                      .withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(order['status'],
                    style: TextStyle(
                      color: order['color'] as Color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}