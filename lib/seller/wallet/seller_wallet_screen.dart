import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class SellerWalletScreen extends StatefulWidget {
  const SellerWalletScreen({super.key});

  @override
  State<SellerWalletScreen> createState() => _SellerWalletScreenState();
}

class _SellerWalletScreenState extends State<SellerWalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Order #ORD-1022',
      'subtitle': 'Sara Khan',
      'amount': '+Rs. 850',
      'date': '03 Apr 2026',
      'type': 'credit',
      'icon': Icons.arrow_downward,
    },
    {
      'title': 'Withdrawal',
      'subtitle': 'Bank Transfer',
      'amount': '-Rs. 5,000',
      'date': '02 Apr 2026',
      'type': 'debit',
      'icon': Icons.arrow_upward,
    },
    {
      'title': 'Order #ORD-1020',
      'subtitle': 'Ayesha Noor',
      'amount': '+Rs. 600',
      'date': '01 Apr 2026',
      'type': 'credit',
      'icon': Icons.arrow_downward,
    },
    {
      'title': 'Order #ORD-1019',
      'subtitle': 'Bilal Raza',
      'amount': '+Rs. 350',
      'date': '31 Mar 2026',
      'type': 'credit',
      'icon': Icons.arrow_downward,
    },
    {
      'title': 'Withdrawal',
      'subtitle': 'Bank Transfer',
      'amount': '-Rs. 3,000',
      'date': '28 Mar 2026',
      'type': 'debit',
      'icon': Icons.arrow_upward,
    },
    {
      'title': 'Order #ORD-1018',
      'subtitle': 'Hira Malik',
      'amount': '+Rs. 1,500',
      'date': '27 Mar 2026',
      'type': 'credit',
      'icon': Icons.arrow_downward,
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

  List<Map<String, dynamic>> get _filtered {
    if (_tabController.index == 1) {
      return transactions.where((t) => t['type'] == 'credit').toList();
    } else if (_tabController.index == 2) {
      return transactions.where((t) => t['type'] == 'debit').toList();
    }
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          _buildHeader(context),
          _buildBalanceCard(),
          _buildQuickActions(context),
          const SizedBox(height: 14),
          _buildTabBar(),
          Expanded(child: _buildTransactionList()),
        ],
      ),
    );
  }

  // ═══ Header ═══
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 55, 20, 60),
      decoration: const BoxDecoration(
        color: SellerColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Wallet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 4),
              Text('Manage your earnings',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.account_balance_wallet_outlined,
                color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  // ═══ Balance Card ═══
  Widget _buildBalanceCard() {
    return Transform.translate(
      offset: const Offset(0, -40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              // Balance Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Available Balance',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 12,
                          )),
                      const SizedBox(height: 8),
                      const Text('Rs. 45,200',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          )),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: SellerColors.primary.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.account_balance_wallet,
                        color: Colors.white, size: 26),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Divider(color: Colors.white.withOpacity(0.15)),
              const SizedBox(height: 16),

              // Earning Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _balanceStat('This Month', 'Rs. 12,800',
                      Icons.trending_up, Colors.green),
                  Container(
                      height: 36,
                      width: 1,
                      color: Colors.white.withOpacity(0.15)),
                  _balanceStat('Withdrawn', 'Rs. 8,000',
                      Icons.outbox_outlined, Colors.orange),
                  Container(
                      height: 36,
                      width: 1,
                      color: Colors.white.withOpacity(0.15)),
                  _balanceStat('Pending', 'Rs. 3,400',
                      Icons.hourglass_top_outlined, Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _balanceStat(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(height: 5),
        Text(value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            )),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 10,
            )),
      ],
    );
  }

  // ═══ Quick Actions ═══
  Widget _buildQuickActions(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: _actionBtn(
                icon: Icons.outbox_outlined,
                label: 'Withdraw',
                color: SellerColors.primary,
                onTap: () => _withdrawSheet(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _actionBtn(
                icon: Icons.account_balance_outlined,
                label: 'Bank Account',
                color: Colors.blue,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _actionBtn(
                icon: Icons.download_outlined,
                label: 'Statement',
                color: Colors.purple,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
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
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 7),
            Text(label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  // ═══ Tab Bar ═══
  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
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
            Tab(text: 'Received'),
            Tab(text: 'Withdrawn'),
          ],
        ),
      ),
    );
  }

  // ═══ Transaction List ═══
  Widget _buildTransactionList() {
    final list = _filtered;

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 60, color: Colors.grey[300]),
            const SizedBox(height: 12),
            const Text('No transactions found',
                style: TextStyle(
                    color: SellerColors.subText, fontSize: 15)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemCount: list.length,
      itemBuilder: (context, index) => _transactionTile(list[index]),
    );
  }

  Widget _transactionTile(Map<String, dynamic> txn) {
    final isCredit = txn['type'] == 'credit';
    final color = isCredit ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(txn['icon'] as IconData, color: color, size: 18),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(txn['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: SellerColors.darkText,
                    )),
                const SizedBox(height: 3),
                Text(txn['subtitle'],
                    style: const TextStyle(
                      color: SellerColors.subText,
                      fontSize: 11,
                    )),
              ],
            ),
          ),

          // Amount + Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(txn['amount'],
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )),
              const SizedBox(height: 3),
              Text(txn['date'],
                  style: const TextStyle(
                    color: SellerColors.subText,
                    fontSize: 11,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  // ═══ Withdraw Bottom Sheet ═══
  void _withdrawSheet(BuildContext context) {
    final controller = TextEditingController();
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
              const SizedBox(height: 20),

              const Text('Withdraw Funds',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: SellerColors.darkText,
                  )),
              const SizedBox(height: 6),
              const Text('Available: Rs. 45,200',
                  style: TextStyle(
                      color: SellerColors.subText, fontSize: 13)),
              const SizedBox(height: 20),

              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  prefixIcon: const Icon(Icons.attach_money,
                      color: SellerColors.primary),
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
              const SizedBox(height: 12),

              // Quick amount chips
              Wrap(
                spacing: 8,
                children: ['1,000', '5,000', '10,000', '20,000']
                    .map(
                      (amt) => GestureDetector(
                        onTap: () =>
                            controller.text = amt.replaceAll(',', ''),
                        child: Chip(
                          label: Text('Rs. $amt'),
                          backgroundColor: SellerColors.lightGreen,
                          labelStyle: const TextStyle(
                            color: SellerColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SellerColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Text('Withdrawal request submitted!'),
                          ],
                        ),
                        backgroundColor: SellerColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  child: const Text('Request Withdrawal',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}