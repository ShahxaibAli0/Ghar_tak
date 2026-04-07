import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class SellerChatsScreen extends StatefulWidget {
  const SellerChatsScreen({super.key});

  @override
  State<SellerChatsScreen> createState() =>
      _SellerChatsScreenState();
}

class _SellerChatsScreenState extends State<SellerChatsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController =
      TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Ali Hassan',
      'lastMsg': 'Kya yeh product available hai?',
      'time': '10:30 AM',
      'unread': 2,
      'avatar': 'A',
      'orderId': '#ORD-1023',
      'online': true,
      'messages': [
        {
          'text': 'Assalam o Alaikum',
          'isSeller': false,
          'time': '10:20 AM'
        },
        {
          'text': 'Walaikum Assalam! Ji farmaiye',
          'isSeller': true,
          'time': '10:22 AM'
        },
        {
          'text': 'Kya yeh product available hai?',
          'isSeller': false,
          'time': '10:30 AM'
        },
      ],
    },
    {
      'name': 'Sara Khan',
      'lastMsg': 'Order kab tak deliver hoga?',
      'time': '9:15 AM',
      'unread': 0,
      'avatar': 'S',
      'orderId': '#ORD-1022',
      'online': true,
      'messages': [
        {
          'text': 'Mera order kab tak aayega?',
          'isSeller': false,
          'time': '9:00 AM'
        },
        {
          'text': 'Aapka order kal tak deliver ho jayega',
          'isSeller': true,
          'time': '9:05 AM'
        },
        {
          'text': 'Order kab tak deliver hoga?',
          'isSeller': false,
          'time': '9:15 AM'
        },
      ],
    },
    {
      'name': 'Usman Tariq',
      'lastMsg': 'Theek hai, shukriya!',
      'time': 'Yesterday',
      'unread': 0,
      'avatar': 'U',
      'orderId': '#ORD-1021',
      'online': false,
      'messages': [
        {
          'text': 'Mujhe 3 pipes chahiye',
          'isSeller': false,
          'time': 'Yesterday'
        },
        {
          'text': 'Ji zaroor, stock available hai',
          'isSeller': true,
          'time': 'Yesterday'
        },
        {
          'text': 'Theek hai, shukriya!',
          'isSeller': false,
          'time': 'Yesterday'
        },
      ],
    },
    {
      'name': 'Ayesha Noor',
      'lastMsg': 'Bohat acha service tha',
      'time': 'Yesterday',
      'unread': 0,
      'avatar': 'A',
      'orderId': '#ORD-1020',
      'online': false,
      'messages': [
        {
          'text': 'Product mil gaya, bohat acha hai',
          'isSeller': false,
          'time': 'Yesterday'
        },
        {
          'text': 'Shukriya! Dobara zaroor aana',
          'isSeller': true,
          'time': 'Yesterday'
        },
        {
          'text': 'Bohat acha service tha',
          'isSeller': false,
          'time': 'Yesterday'
        },
      ],
    },
    {
      'name': 'Bilal Raza',
      'lastMsg': 'Refund kab milega?',
      'time': '2 days ago',
      'unread': 1,
      'avatar': 'B',
      'orderId': '#ORD-1019',
      'online': false,
      'messages': [
        {
          'text': 'Mera order cancel ho gaya',
          'isSeller': false,
          'time': '2 days ago'
        },
        {
          'text': 'Ji hum process kar rahe hain',
          'isSeller': true,
          'time': '2 days ago'
        },
        {
          'text': 'Refund kab milega?',
          'isSeller': false,
          'time': '2 days ago'
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_searchQuery.isEmpty) return chats;
    return chats
        .where((c) => c['name']
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  int get _unreadTotal =>
      chats.fold(0, (sum, c) => sum + (c['unread'] as int));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          _buildTabBar(),
          Expanded(child: _buildChatList()),
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
        color: SellerColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${chats.length} conversations',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (_unreadTotal > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$_unreadTotal Unread',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
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
        controller: _searchController,
        onChanged: (val) =>
            setState(() => _searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Search conversations...',
          hintStyle: const TextStyle(
              color: SellerColors.subText, fontSize: 13),
          prefixIcon: const Icon(Icons.search,
              color: SellerColors.primary, size: 20),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear,
                      color: SellerColors.subText, size: 18),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
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
                color: SellerColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }

  // ═══ Tab Bar ═══
  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
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
            const Tab(text: 'All Chats'),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Unread'),
                  if (_unreadTotal > 0) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _tabController.index == 1
                            ? Colors.white
                            : SellerColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$_unreadTotal',
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

  // ═══ Chat List ═══
  Widget _buildChatList() {
    List<Map<String, dynamic>> list = _filtered;
    if (_tabController.index == 1) {
      list = list
          .where((c) => (c['unread'] as int) > 0)
          .toList();
    }

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline,
                size: 64, color: Colors.grey[300]),
            const SizedBox(height: 12),
            const Text(
              'No conversations',
              style: TextStyle(
                color: SellerColors.subText,
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: list.length,
      itemBuilder: (context, index) =>
          _chatTile(context, list[index]),
    );
  }

  // ═══ Chat Tile ═══
  Widget _chatTile(
      BuildContext context, Map<String, dynamic> chat) {
    final bool hasUnread = (chat['unread'] as int) > 0;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => _ChatDetailScreen(chat: chat),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
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
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor:
                      SellerColors.primary.withOpacity(0.15),
                  child: Text(
                    chat['avatar'],
                    style: const TextStyle(
                      color: SellerColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                if (chat['online'] == true)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat['name'],
                        style: TextStyle(
                          fontWeight: hasUnread
                              ? FontWeight.bold
                              : FontWeight.w600,
                          fontSize: 14,
                          color: SellerColors.darkText,
                        ),
                      ),
                      Text(
                        chat['time'],
                        style: TextStyle(
                          color: hasUnread
                              ? SellerColors.primary
                              : SellerColors.subText,
                          fontSize: 11,
                          fontWeight: hasUnread
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // Order badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: SellerColors.lightGreen,
                          borderRadius:
                              BorderRadius.circular(6),
                        ),
                        child: Text(
                          chat['orderId'],
                          style: const TextStyle(
                            color: SellerColors.primary,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          chat['lastMsg'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: hasUnread
                                ? SellerColors.darkText
                                : SellerColors.subText,
                            fontSize: 12,
                            fontWeight: hasUnread
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (hasUnread)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: SellerColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${chat['unread']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
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
    );
  }
}

// ═══════════════════════════════════════
// Chat Detail Screen
// ═══════════════════════════════════════
class _ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> chat;
  const _ChatDetailScreen({required this.chat});

  @override
  State<_ChatDetailScreen> createState() =>
      _ChatDetailScreenState();
}

class _ChatDetailScreenState
    extends State<_ChatDetailScreen> {
  final TextEditingController _msgController =
      TextEditingController();
  final ScrollController _scrollController =
      ScrollController();

  late List<Map<String, dynamic>> _messages;

  final List<String> _quickReplies = [
    'Ji zaroor!',
    'Shukriya aapka!',
    'Hum jald deliver karenge',
    'Stock available hai',
    'Abhi check karta hun',
  ];

  @override
  void initState() {
    super.initState();
    _messages = List<Map<String, dynamic>>.from(
        widget.chat['messages'] as List);
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'text': text.trim(),
        'isSeller': true,
        'time': 'Now',
      });
    });
    _msgController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Column(
        children: [
          _buildHeader(context),
          _buildOrderBanner(),
          Expanded(child: _buildMessages()),
          _buildQuickReplies(),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 54, 16, 14),
      color: SellerColors.primary,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 17),
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor:
                    Colors.white.withOpacity(0.25),
                child: Text(
                  widget.chat['avatar'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              if (widget.chat['online'] == true)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: SellerColors.primary,
                          width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.chat['online'] == true
                      ? 'Online'
                      : 'Offline',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined,
                color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 10),
      color: SellerColors.lightGreen,
      child: Row(
        children: [
          const Icon(Icons.shopping_bag_outlined,
              color: SellerColors.primary, size: 16),
          const SizedBox(width: 8),
          Text(
            'Order ${widget.chat['orderId']}',
            style: const TextStyle(
              color: SellerColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          const Text(
            'View Order',
            style: TextStyle(
              color: SellerColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 10, color: SellerColors.primary),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        final bool isSeller = msg['isSeller'] as bool;
        return _messageBubble(
            msg['text'], msg['time'], isSeller);
      },
    );
  }

  Widget _messageBubble(
      String text, String time, bool isSeller) {
    return Align(
      alignment: isSeller
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        child: Column(
          crossAxisAlignment: isSeller
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSeller
                    ? SellerColors.primary
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(
                      isSeller ? 16 : 4),
                  bottomRight: Radius.circular(
                      isSeller ? 4 : 16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isSeller
                      ? Colors.white
                      : SellerColors.darkText,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              time,
              style: const TextStyle(
                color: SellerColors.subText,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReplies() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _quickReplies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _sendMessage(_quickReplies[index]),
            child: Container(
              margin: const EdgeInsets.only(
                  right: 8, top: 4, bottom: 4),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: SellerColors.lightGreen,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      SellerColors.primary.withOpacity(0.3),
                ),
              ),
              child: Text(
                _quickReplies[index],
                style: const TextStyle(
                  color: SellerColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom:
            MediaQuery.of(context).viewInsets.bottom + 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _msgController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(
                    color: SellerColors.subText,
                    fontSize: 13),
                filled: true,
                fillColor: const Color(0xFFF4F6F8),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => _sendMessage(_msgController.text),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: SellerColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}