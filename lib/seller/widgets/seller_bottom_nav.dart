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

class _SellerBottomNavState
    extends State<SellerBottomNav> {
  int _currentIndex = 0;

  void _switchTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      SellerHomeScreen(onTabSwitch: _switchTab),
      SellerToolsScreen(onTabSwitch: _switchTab),
      const SellerChatsScreen(),
      const SellerMeScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 16,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          _navItem(
            index: 0,
            outlineIcon: Icons.home_outlined,
            filledIcon: Icons.home_rounded,
            label: 'Home',
          ),
          _navItem(
            index: 1,
            outlineIcon: Icons.storefront_outlined,
            filledIcon: Icons.storefront_rounded,
            label: 'Tools',
          ),
          _navItem(
            index: 2,
            outlineIcon:
                Icons.chat_bubble_outline_rounded,
            filledIcon: Icons.chat_bubble_rounded,
            label: 'Chats',
          ),
          _navItem(
            index: 3,
            outlineIcon:
                Icons.person_outline_rounded,
            filledIcon: Icons.person_rounded,
            label: 'Me',
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData outlineIcon,
    required IconData filledIcon,
    required String label,
  }) {
    final bool selected = _currentIndex == index;

    return GestureDetector(
      onTap: () => _switchTab(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration:
                  const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                color: selected
                    ? SellerColors.primary
                        .withOpacity(0.12)
                    : Colors.transparent,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Icon(
                selected ? filledIcon : outlineIcon,
                color: selected
                    ? SellerColors.primary
                    : SellerColors.subText,
                size: 24,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: selected
                    ? SellerColors.primary
                    : SellerColors.subText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}