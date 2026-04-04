import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class SellerReportsScreen extends StatefulWidget {
  const SellerReportsScreen({super.key});

  @override
  State<SellerReportsScreen> createState() =>
      _SellerReportsScreenState();
}

class _SellerReportsScreenState extends State<SellerReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'This Month';

  final List<String> periods = [
    'Today',
    'This Week',
    'This Month',
    'This Year',
  ];

  // ── Weekly Earnings Data ──
  final List<Map<String, dynamic>> weeklyData = [
    {'day': 'Mon', 'amount': 3200, 'orders': 4},
    {'day': 'Tue', 'amount': 5800, 'orders': 7},
    {'day': 'Wed', 'amount': 2400, 'orders': 3},
    {'day': 'Thu', 'amount': 7200, 'orders': 9},
    {'day': 'Fri', 'amount': 6100, 'orders': 8},
    {'day': 'Sat', 'amount': 9400, 'orders': 12},
    {'day': 'Sun', 'amount': 4300, 'orders': 5},
  ];

  // ── Top Products ──
  final List<Map<String, dynamic>> topProducts = [
    {
      'name': 'LED Bulb 12W',
      'sales': 48,
      'revenue': 'Rs. 16,800',
      'percent': 0.85,
      'icon': Icons.lightbulb,
      'color': Colors.yellow,
    },
    {
      'name': 'Basmati Rice 5kg',
      'sales': 30,
      'revenue': 'Rs. 36,000',
      'percent': 0.65,
      'icon': Icons.rice_bowl,
      'color': Colors.brown,
    },
    {
      'name': 'Panadol 10 Tabs',
      'sales': 25,
      'revenue': 'Rs. 2,000',
      'percent': 0.50,
      'icon': Icons.medication,
      'color': Colors.red,
    },
    {
      'name': 'PVC Pipe 1 inch',
      'sales': 18,
      'revenue': 'Rs. 2,160',
      'percent': 0.38,
      'icon': Icons.plumbing,
      'color': Colors.grey,
    },
    {
      'name': 'Wood Screw Set',
      'sales': 12,
      'revenue': 'Rs. 3,000',
      'percent': 0.25,
      'icon': Icons.handyman,
      'color': Colors.blueGrey,
    },
  ];

  // ── Category Data ──
  final List<Map<String, dynamic>> categoryData = [
    {'name': 'Electric', 'percent': 0.40, 'color': Colors.blue},
    {'name': 'Grocery', 'percent': 0.28, 'color': Colors.green},
    {'name': 'Hardware', 'percent': 0.18, 'color': Colors.orange},
    {'name': 'Pharmacies', 'percent': 0.14, 'color': Colors.red},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int get _maxAmount =>
      weeklyData.map((d) => d['amount'] as int).reduce(
          (a, b) => a > b ? a : b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildPeriodSelector(),
            const SizedBox(height: 16),
            _buildSummaryCards(),
            const SizedBox(height: 16),
            _buildEarningsChart(),
            const SizedBox(height: 16),
            _buildTabSection(),
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reports & Earnings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Track your performance',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          // Download Button
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.download_outlined,
                color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  // ═══ Period Selector ═══
  Widget _buildPeriodSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: periods.map((period) {
            final bool selected = _selectedPeriod == period;
            return GestureDetector(
              onTap: () =>
                  setState(() => _selectedPeriod = period),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 9),
                decoration: BoxDecoration(
                  color: selected
                      ? SellerColors.primary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? SellerColors.primary
                        : Colors.grey.withOpacity(0.3),
                  ),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: SellerColors.primary
                                .withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ]
                      : [],
                ),
                child: Text(
                  period,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : SellerColors.subText,
                    fontWeight: selected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ═══ Summary Cards ═══
  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // ── Big Earning Card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00A651), Color(0xFF007A3D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: SellerColors.primary.withOpacity(0.35),
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
                    Text(
                      'Total Revenue — $_selectedPeriod',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 13,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.trending_up,
                              color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            '+18%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Rs. 45,200',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                  children: [
                    _earningMini('Orders', '248',
                        Icons.receipt_long_outlined),
                    _vDivider(),
                    _earningMini('Delivered', '210',
                        Icons.check_circle_outline),
                    _vDivider(),
                    _earningMini('Cancelled', '14',
                        Icons.cancel_outlined),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 3 Small Cards ──
          Row(
            children: [
              Expanded(
                child: _miniCard(
                  'Avg Order',
                  'Rs. 182',
                  Icons.shopping_cart_outlined,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _miniCard(
                  'New Customers',
                  '38',
                  Icons.person_add_outlined,
                  Colors.purple,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _miniCard(
                  'Return Rate',
                  '5.6%',
                  Icons.replay_outlined,
                  Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _earningMini(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _vDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.25),
    );
  }

  Widget _miniCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: SellerColors.darkText,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: SellerColors.subText,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Earnings Chart (Manual Bar Chart) ═══
  Widget _buildEarningsChart() {
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
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Earnings',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: SellerColors.darkText,
                      ),
                    ),
                    Text(
                      'Last 7 days performance',
                      style: TextStyle(
                        color: SellerColors.subText,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: SellerColors.lightGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Rs. 38,400',
                    style: TextStyle(
                      color: SellerColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Bar Chart ──
            SizedBox(
              height: 160,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: weeklyData.map((data) {
                  final int amount = data['amount'] as int;
                  final double heightRatio =
                      amount / _maxAmount;
                  final bool isMax = amount == _maxAmount;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Amount label
                      if (isMax)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: SellerColors.primary,
                            borderRadius:
                                BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${(amount / 1000).toStringAsFixed(1)}k',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (isMax) const SizedBox(height: 4),

                      // Bar
                      AnimatedContainer(
                        duration: const Duration(
                            milliseconds: 600),
                        curve: Curves.easeOut,
                        width: 30,
                        height: 120 * heightRatio,
                        decoration: BoxDecoration(
                          color: isMax
                              ? SellerColors.primary
                              : SellerColors.primary
                                  .withOpacity(0.25),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Day label
                      Text(
                        data['day'],
                        style: TextStyle(
                          color: isMax
                              ? SellerColors.primary
                              : SellerColors.subText,
                          fontSize: 11,
                          fontWeight: isMax
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 14),
            const Divider(color: Color(0xFFF0F0F0)),
            const SizedBox(height: 10),

            // ── Legend ──
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendDot(SellerColors.primary, 'Highest Day'),
                const SizedBox(width: 20),
                _legendDot(
                    SellerColors.primary.withOpacity(0.25),
                    'Other Days'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: SellerColors.subText,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // ═══ Tab Section ═══
  Widget _buildTabSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Tab Bar
          Container(
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
                Tab(text: 'Top Products'),
                Tab(text: 'By Category'),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Tab Content
          _tabController.index == 0
              ? _buildTopProducts()
              : _buildCategoryBreakdown(),
        ],
      ),
    );
  }

  // ═══ Top Products ═══
  Widget _buildTopProducts() {
    return Container(
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
        children: topProducts.asMap().entries.map((entry) {
          final int i = entry.key;
          final Map<String, dynamic> product = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                // Rank
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: i == 0
                        ? Colors.amber.withOpacity(0.15)
                        : SellerColors.lightGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: i == 0
                            ? Colors.amber
                            : SellerColors.subText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (product['color'] as Color)
                        .withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    product['icon'] as IconData,
                    color: product['color'] as Color,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),

                // Name + Bar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: SellerColors.darkText,
                            ),
                          ),
                          Text(
                            product['revenue'],
                            style: const TextStyle(
                              color: SellerColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: product['percent']
                                    as double,
                                backgroundColor:
                                    Colors.grey[200],
                                color: SellerColors.primary,
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${product['sales']} sold',
                            style: const TextStyle(
                              color: SellerColors.subText,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ═══ Category Breakdown ═══
  Widget _buildCategoryBreakdown() {
    return Container(
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
          ...categoryData.map((cat) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: cat['color'] as Color,
                              borderRadius:
                                  BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            cat['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: SellerColors.darkText,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${((cat['percent'] as double) * 100).toInt()}%',
                        style: TextStyle(
                          color: cat['color'] as Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: cat['percent'] as double,
                      backgroundColor: Colors.grey[200],
                      color: cat['color'] as Color,
                      minHeight: 10,
                    ),
                  ),
                ],
              ),
            );
          }),

          const Divider(color: Color(0xFFF0F0F0)),
          const SizedBox(height: 10),

          // Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: categoryData.map((cat) {
              return Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color)
                          .withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${((cat['percent'] as double) * 100).toInt()}%',
                        style: TextStyle(
                          color: cat['color'] as Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    cat['name'],
                    style: const TextStyle(
                      color: SellerColors.subText,
                      fontSize: 10,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
