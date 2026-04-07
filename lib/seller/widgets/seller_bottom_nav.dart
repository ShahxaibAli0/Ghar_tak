import 'package:flutter/material.dart';
import 'seller_colors.dart';
import '../home/seller_home_screen.dart';
import '../tools/seller_tools_screen.dart';
import '../chats/seller_chats_screen.dart';
import '../me/seller_me_screen.dart';

class SellerBottomNav extends StatefulWidget {
  const SellerBottomNav({super.key});

  @override
  State<SellerBottomNav> createState() =>
      _SellerBottomNavState();
}

class _SellerBottomNavState extends State<SellerBottomNav> {
  int _currentIndex = 0;

  void _switchTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      SellerHomeScreen(onTabSwitch: _switchTab),
      const SellerToolsScreen(),
      const SellerChatsScreen(),
      const SellerMeScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                _navItem(0, Icons.home_outlined,
                    Icons.home, 'Home'),
                _navItem(1, Icons.storefront_outlined,
                    Icons.storefront, 'Tools'),
                _navItem(2, Icons.chat_bubble_outline,
                    Icons.chat_bubble, 'Chats'),
                _navItem(3, Icons.person_outline,
                    Icons.person, 'Me'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData outlineIcon,
      IconData filledIcon, String label) {
    final bool selected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _switchTab(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? SellerColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? filledIcon : outlineIcon,
              color: selected
                  ? SellerColors.primary
                  : Colors.grey[400],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? SellerColors.primary
                    : Colors.grey[400],
                fontSize: 11,
                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}