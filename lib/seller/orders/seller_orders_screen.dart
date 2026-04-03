import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';
import 'order_detail_screen.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({super.key});

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<Map<String, dynamic>> orders = [
    {
      'id': '#ORD-1023',
      'name': 'Ali Hassan',
      'phone': '0300-1234567',
      'address': 'House 12, Block B, Gulshan-e-Iqbal, Karachi',
      'items': 3,
      'amount': 'Rs. 1,200',
      'status': 'Pending',
      'date': '04 Apr 2026',
      'time': '10:30 AM',
      'products': ['LED Bulb x2', 'Wire Roll x1'],
    },
    {
      'id': '#ORD-1022',
      'name': 'Sara Khan',
      'phone': '0311-9876543',
      'address': 'Flat 5, DHA Phase 2, Lahore',
      'items': 1,
      'amount': 'Rs. 850',
      'status': 'Processing',
      'date': '03 Apr 2026',
      'time': '02:15 PM',
      'products': ['Basmati Rice 5kg x1'],
    },
    {
      'id': '#ORD-1021',
      'name': 'Usman Tariq',
      'phone': '0333-5556677',
      'address': 'Street 4, F-8/3, Islamabad',
      'items': 5,
      'amount': 'Rs. 3,400',
      'status': 'Shipped',
      'date': '02 Apr 2026',
      'time': '11:00 AM',
      'products': ['PVC Pipe x3', 'Wood Screw Set x2'],
    },
    {
      'id': '#ORD-1020',
      'name': 'Ayesha Noor',
      'phone': '0321-4445566',
      'address': 'Plot 99, Model Town, Multan',
      'items': 2,
      'amount': 'Rs. 600',
      'status': 'Delivered',
      'date': '01 Apr 2026',
      'time': '09:45 AM',
      'products': ['Panadol x4', 'Bandage Roll x1'],
    },
    {
      'id': '#ORD-1019',
      'name': 'Bilal Raza',
      'phone': '0345-7778899',
      'address': 'House 3, Johar Town, Lahore',
      'items': 1,
      'amount': 'Rs. 350',
      'status': 'Cancelled',
      'date': '31 Mar 2026',
      'time': '04:00 PM',
      'products': ['LED Bulb 12W x1'],
    },
  ];

  final List<String> tabs = [
    'All', 'Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredOrders {
    List<Map<String, dynamic>> list = orders;

    final tab = tabs[_tabController.index];
    if (tab != 'All') {
      list = list.where((o) => o['status'] == tab).toList();
    }

    if (_searchQuery.isNotEmpty) {
      list = list
          .where((o) =>
              o['name']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              o['id']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return list;
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Processing':
        return Colors.blue;
      case 'Shipped':
        return Colors.purple;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.hourglass_top;
      case 'Processing':
        return Icons.sync;
      case 'Shipped':
        return Icons.local_shipping;
      case 'Delivered':
        return Icons.check_circle;
      case 'Cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabs
                  .map((_) => _buildOrderList())
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Header ═══
  Widget _buildHeader() {
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
              Text('My Orders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 4),
              Text('Track & manage all orders',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${orders.length} Orders',
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

  // ═══ Search Bar ═══
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: TextField(
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Search by name or order ID...',
          hintStyle:
              const TextStyle(color: SellerColors.subText, fontSize: 13),
          prefixIcon:
              const Icon(Icons.search, color: SellerColors.primary),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear,
                      color: SellerColors.subText),
                  onPressed: () => setState(() => _searchQuery = ''),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                const BorderSide(color: SellerColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }

  // ═══ Tab Bar ═══
  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 0, 10),
      child: SizedBox(
        height: 42,
        child: TabBar(
          controller: _tabController,
          onTap: (_) => setState(() {}),
          isScrollable: true,
          indicator: BoxDecoration(
            color: SellerColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(vertical: 4),
          labelColor: Colors.white,
          unselectedLabelColor: SellerColors.subText,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12),
          tabs: tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
    );
  }

  // ═══ Order List ═══
  Widget _buildOrderList() {
    final list = _filteredOrders;

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 64, color: Colors.grey[300]),
            const SizedBox(height: 12),
            const Text('No orders found',
                style: TextStyle(
                    color: SellerColors.subText, fontSize: 15)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: list.length,
      itemBuilder: (context, index) => _orderCard(list[index]),
    );
  }

  // ═══ Order Card ═══
  Widget _orderCard(Map<String, dynamic> order) {
    final color = _statusColor(order['status']);
    final icon = _statusIcon(order['status']);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrderDetailScreen(order: order),
        ),
      ),
      child: Container(
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
        child: Column(
          children: [
            // ── Top Row ──
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              child: Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  // Order Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order['id'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: SellerColors.darkText,
                            )),
                        const SizedBox(height: 3),
                        Text(
                          '${order['date']}  •  ${order['time']}',
                          style: const TextStyle(
                            color: SellerColors.subText,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order['status'],
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Divider ──
            Divider(
                height: 1,
                color: Colors.grey[100],
                indent: 14,
                endIndent: 14),

            // ── Bottom Row ──
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
              child: Row(
                children: [
                  const Icon(Icons.person_outline,
                      size: 16, color: SellerColors.subText),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(order['name'],
                        style: const TextStyle(
                          color: SellerColors.darkText,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        )),
                  ),
                  const Icon(Icons.shopping_bag_outlined,
                      size: 15, color: SellerColors.subText),
                  const SizedBox(width: 4),
                  Text('${order['items']} items',
                      style: const TextStyle(
                        color: SellerColors.subText,
                        fontSize: 12,
                      )),
                  const SizedBox(width: 12),
                  Text(order['amount'],
                      style: const TextStyle(
                        color: SellerColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ],
              ),
            ),

            // ── Action Buttons (Pending only) ──
            if (order['status'] == 'Pending')
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.close,
                            size: 15, color: Colors.red),
                        label: const Text('Reject',
                            style: TextStyle(
                                color: Colors.red, fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.check,
                            size: 15, color: Colors.white),
                        label: const Text('Accept',
                            style: TextStyle(
                                color: Colors.white, fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SellerColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              const EdgeInsets.symmetric(vertical: 8),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}