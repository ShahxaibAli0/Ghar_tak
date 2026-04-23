import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';
import '../products/my_products_screen.dart';
import '../products/add_product_screen.dart';
import '../orders/seller_orders_screen.dart';
import '../reports/seller_reports_screen.dart';
import '../reviews/seller_reviews_screen.dart';
import '../wallet/seller_wallet_screen.dart';
import '../notifications/seller_notifications_screen.dart';

class SellerToolsScreen extends StatelessWidget {
  final Function(int)? onTabSwitch;
  const SellerToolsScreen({super.key, this.onTabSwitch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(
              child: _buildWalletCard(context)),
          SliverToBoxAdapter(
              child: _buildSection(
            context,
            'Products',
            Icons.inventory_2_outlined,
            Colors.orange,
            _productTools(),
          )),
          SliverToBoxAdapter(
              child: _buildSection(
            context,
            'Orders',
            Icons.receipt_long_outlined,
            Colors.blue,
            _orderTools(),
          )),
          SliverToBoxAdapter(
              child: _buildSection(
            context,
            'Analytics',
            Icons.bar_chart_outlined,
            Colors.teal,
            _analyticsTools(),
          )),
          SliverToBoxAdapter(
              child: _buildSection(
            context,
            'Notifications',
            Icons.notifications_outlined,
            Colors.purple,
            _notifTools(),
          )),
          const SliverToBoxAdapter(
              child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  // ═══ Header ═══
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 22),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tools',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Manage your store efficiently',
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Wallet Card ═══
  Widget _buildWalletCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const SellerWalletScreen()),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1A1A2E),
                Color(0xFF16213E),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Balance',
                        style: TextStyle(
                          color: Colors.white
                              .withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Rs. 45,200',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: SellerColors.primary
                          .withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _walletStat('This Month',
                        'Rs. 12,800',
                        Icons.trending_up,
                        Colors.green),
                  ),
                  Container(
                    height: 32,
                    width: 1,
                    color: Colors.white.withOpacity(0.15),
                  ),
                  Expanded(
                    child: _walletStat('Withdrawn',
                        'Rs. 8,000',
                        Icons.outbox_outlined,
                        Colors.orange),
                  ),
                  Container(
                    height: 32,
                    width: 1,
                    color: Colors.white.withOpacity(0.15),
                  ),
                  Expanded(
                    child: _walletStat('Pending',
                        'Rs. 3,400',
                        Icons.hourglass_top_outlined,
                        Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SellerColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const SellerWalletScreen()),
                  ),
                  icon: const Icon(
                      Icons.outbox_outlined,
                      color: Colors.white,
                      size: 17),
                  label: const Text(
                    'Withdraw Funds',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _walletStat(String label, String value,
      IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 15),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            )),
        Text(label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 10,
            )),
      ],
    );
  }

  // ═══ Section Builder ═══
  Widget _buildSection(
    BuildContext context,
    String title,
    IconData sectionIcon,
    Color sectionColor,
    List<_ToolItem> items,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color:
                      sectionColor.withOpacity(0.12),
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                child: Icon(sectionIcon,
                    color: sectionColor, size: 15),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: SellerColors.darkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
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
              children:
                  items.asMap().entries.map((entry) {
                final int i = entry.key;
                final _ToolItem item = entry.value;
                final bool isLast =
                    i == items.length - 1;
                return Column(
                  children: [
                    ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                item.screen),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: item.color
                              .withOpacity(0.12),
                          borderRadius:
                              BorderRadius.circular(11),
                        ),
                        child: Icon(item.icon,
                            color: item.color,
                            size: 19),
                      ),
                      title: Text(item.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: SellerColors.darkText,
                          )),
                      subtitle: Text(item.subtitle,
                          style: const TextStyle(
                            fontSize: 11,
                            color: SellerColors.subText,
                          )),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.badge != null)
                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: item.badgeColor
                                        ?.withOpacity(
                                            0.12) ??
                                    SellerColors
                                        .lightGreen,
                                borderRadius:
                                    BorderRadius
                                        .circular(20),
                              ),
                              child: Text(
                                item.badge!,
                                style: TextStyle(
                                  color:
                                      item.badgeColor ??
                                          SellerColors
                                              .primary,
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          const SizedBox(width: 4),
                          const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Color(0xFFCCCCCC)),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Divider(
                        height: 1,
                        color: Colors.grey[100],
                        indent: 56,
                        endIndent: 16,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Tool Lists ═══
  List<_ToolItem> _productTools() => [
        _ToolItem(
          title: 'My Products',
          subtitle: 'View and manage all products',
          icon: Icons.inventory_2_outlined,
          color: Colors.orange,
          badge: '56 Items',
          badgeColor: Colors.orange,
          screen: const MyProductsScreen(),
        ),
        _ToolItem(
          title: 'Add New Product',
          subtitle: 'List a new item for sale',
          icon: Icons.add_circle_outline,
          color: SellerColors.primary,
          badge: null,
          badgeColor: null,
          screen: const AddProductScreen(),
        ),
        _ToolItem(
          title: 'Out of Stock',
          subtitle: 'Items that need restocking',
          icon: Icons.warning_amber_outlined,
          color: Colors.red,
          badge: '4 Items',
          badgeColor: Colors.red,
          screen: const MyProductsScreen(),
        ),
      ];

  List<_ToolItem> _orderTools() => [
        _ToolItem(
          title: 'All Orders',
          subtitle: 'View and manage orders',
          icon: Icons.receipt_long_outlined,
          color: Colors.blue,
          badge: '248 Total',
          badgeColor: Colors.blue,
          screen: const SellerOrdersScreen(),
        ),
        _ToolItem(
          title: 'Pending Orders',
          subtitle: 'Orders waiting for action',
          icon: Icons.hourglass_top_outlined,
          color: Colors.orange,
          badge: '18 New',
          badgeColor: Colors.orange,
          screen: const SellerOrdersScreen(),
        ),
        _ToolItem(
          title: 'Customer Reviews',
          subtitle: 'See what customers say',
          icon: Icons.star_outline,
          color: Colors.amber,
          badge: '4.8 Stars',
          badgeColor: Colors.amber,
          screen: const SellerReviewsScreen(),
        ),
      ];

  List<_ToolItem> _analyticsTools() => [
        _ToolItem(
          title: 'Reports',
          subtitle: 'Track your performance',
          icon: Icons.bar_chart_outlined,
          color: Colors.teal,
          badge: '+18% Growth',
          badgeColor: Colors.teal,
          screen: const SellerReportsScreen(),
        ),
        _ToolItem(
          title: 'Wallet',
          subtitle: 'Balance, withdraw, history',
          icon: Icons.account_balance_wallet_outlined,
          color: const Color(0xFF1A73E8),
          badge: 'Rs. 45,200',
          badgeColor: const Color(0xFF1A73E8),
          screen: const SellerWalletScreen(),
        ),
      ];

  List<_ToolItem> _notifTools() => [
        _ToolItem(
          title: 'Notifications',
          subtitle: 'Order alerts and updates',
          icon: Icons.notifications_outlined,
          color: Colors.purple,
          badge: '3 New',
          badgeColor: Colors.purple,
          screen: const SellerNotificationsScreen(),
        ),
      ];
}

// ═══ Tool Item Model ═══
class _ToolItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? badge;
  final Color? badgeColor;
  final Widget screen;

  _ToolItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.badge,
    required this.badgeColor,
    required this.screen,
  });
}