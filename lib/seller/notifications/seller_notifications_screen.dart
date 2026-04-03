import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class SellerNotificationsScreen extends StatefulWidget {
  const SellerNotificationsScreen({super.key});

  @override
  State<SellerNotificationsScreen> createState() =>
      _SellerNotificationsScreenState();
}

class _SellerNotificationsScreenState
    extends State<SellerNotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Order Received! 🎉',
      'body': 'Ali Hassan ne Rs. 1,200 ka order place kiya hai.',
      'time': '2 min ago',
      'type': 'order',
      'isRead': false,
      'icon': Icons.shopping_bag,
      'color': Colors.green,
    },
    {
      'title': 'Order Delivered ✅',
      'body': 'Order #ORD-1020 successfully deliver ho gaya.',
      'time': '1 hour ago',
      'type': 'delivery',
      'isRead': false,
      'icon': Icons.check_circle,
      'color': Colors.blue,
    },
    {
      'title': 'Payment Received 💰',
      'body': 'Rs. 850 aapke wallet mein add ho gaye hain.',
      'time': '3 hours ago',
      'type': 'payment',
      'isRead': false,
      'icon': Icons.account_balance_wallet,
      'color': Color(0xFF00A651),
    },
    {
      'title': 'Order Cancelled ❌',
      'body': 'Bilal Raza ne order #ORD-1019 cancel kar diya.',
      'time': '5 hours ago',
      'type': 'cancel',
      'isRead': true,
      'icon': Icons.cancel,
      'color': Colors.red,
    },
    {
      'title': 'Low Stock Alert ⚠️',
      'body': 'LED Bulb 12W ka stock sirf 3 reh gaya hai.',
      'time': '1 day ago',
      'type': 'alert',
      'isRead': true,
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'title': 'New Review ⭐',
      'body': 'Sara Khan ne aapki shop ko 5 star diya!',
      'time': '1 day ago',
      'type': 'review',
      'isRead': true,
      'icon': Icons.star,
      'color': Colors.amber,
    },
    {
      'title': 'Payment Received 💰',
      'body': 'Rs. 3,400 aapke wallet mein add ho gaye hain.',
      'time': '2 days ago',
      'type': 'payment',
      'isRead': true,
      'icon': Icons.account_balance_wallet,
      'color': Color(0xFF00A651),
    },
    {
      'title': 'New Order Received! 🎉',
      'body': 'Usman Tariq ne Rs. 3,400 ka order place kiya hai.',
      'time': '2 days ago',
      'type': 'order',
      'isRead': true,
      'icon': Icons.shopping_bag,
      'color': Colors.green,
    },
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

  int get _unreadCount =>
      notifications.where((n) => n['isRead'] == false).length;

  List<Map<String, dynamic>> get _filtered {
    if (_tabController.index == 1) {
      return notifications.where((n) => n['isRead'] == false).toList();
    }
    return notifications;
  }

  void _markAllRead() {
    setState(() {
      for (var n in notifications) {
        n['isRead'] = true;
      }
    });
  }

  void _markOneRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotificationList(),
                _buildNotificationList(),
              ],
            ),
          ),
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
          // Back + Title
          Row(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Notifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  if (_unreadCount > 0)
                    Text(
                      '$_unreadCount unread notifications',
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 12),
                    ),
                ],
              ),
            ],
          ),

          // Mark all read
          if (_unreadCount > 0)
            GestureDetector(
              onTap: _markAllRead,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.4)),
                ),
                child: const Text(
                  'Mark all read',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ═══ Tab Bar ═══
  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
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
          tabs: [
            const Tab(text: 'All'),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Unread'),
                  if (_unreadCount > 0) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: _tabController.index == 1
                            ? Colors.white
                            : SellerColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$_unreadCount',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _tabController.index == 1
                              ? SellerColors.primary
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══ Notification List ═══
  Widget _buildNotificationList() {
    final list = _filtered;

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off_outlined,
                size: 70, color: Colors.grey[300]),
            const SizedBox(height: 14),
            const Text('No notifications',
                style: TextStyle(
                  color: SellerColors.subText,
                  fontSize: 16,
                )),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final realIndex = notifications.indexOf(list[index]);
        return _notificationCard(list[index], realIndex);
      },
    );
  }

  // ═══ Notification Card ═══
  Widget _notificationCard(Map<String, dynamic> notif, int index) {
    final bool isRead = notif['isRead'] as bool;
    final Color color = notif['color'] as Color;

    return Dismissible(
      key: Key('$index${notif['title']}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 24),
            SizedBox(height: 4),
            Text('Delete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      onDismissed: (_) => _deleteNotification(index),
      child: GestureDetector(
        onTap: () => _markOneRead(index),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isRead ? Colors.white : SellerColors.lightGreen,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isRead
                  ? Colors.transparent
                  : SellerColors.primary.withOpacity(0.25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(notif['icon'] as IconData,
                    color: color, size: 22),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notif['title'],
                            style: TextStyle(
                              fontWeight: isRead
                                  ? FontWeight.w500
                                  : FontWeight.bold,
                              fontSize: 13,
                              color: SellerColors.darkText,
                            ),
                          ),
                        ),
                        // Unread dot
                        if (!isRead)
                          Container(
                            width: 9,
                            height: 9,
                            decoration: const BoxDecoration(
                              color: SellerColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notif['body'],
                      style: const TextStyle(
                        color: SellerColors.subText,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 12,
                            color: Colors.grey[400]),
                        const SizedBox(width: 4),
                        Text(
                          notif['time'],
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 11,
                          ),
                        ),
                        const Spacer(),
                        // Type badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _typeLabel(notif['type']),
                            style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'order':    return 'New Order';
      case 'delivery': return 'Delivery';
      case 'payment':  return 'Payment';
      case 'cancel':   return 'Cancelled';
      case 'alert':    return 'Alert';
      case 'review':   return 'Review';
      default:         return 'Info';
    }
  }
}