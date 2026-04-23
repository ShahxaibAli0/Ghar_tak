import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../widgets/seller_colors.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

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

  // Returns (originalIndex, product) pairs after applying tab + search filters
  List<MapEntry<int, Map<String, dynamic>>> _filtered(
      List<Map<String, dynamic>> all) {
    var entries = [
      for (int i = 0; i < all.length; i++) MapEntry(i, all[i]),
    ];

    if (_tabController.index == 1) {
      entries = entries.where((e) => e.value['status'] == 'Active').toList();
    } else if (_tabController.index == 2) {
      entries =
          entries.where((e) => e.value['status'] == 'Out of Stock').toList();
    }

    if (_searchQuery.isNotEmpty) {
      entries = entries
          .where((e) => (e.value['name'] as String? ?? '')
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return entries;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        final all = provider.products;

        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: AppBar(
            backgroundColor: SellerColors.primary,
            elevation: 0,
            toolbarHeight: 86,
            shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
            titleSpacing: 0,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'My Products',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage your inventory',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${all.length} Products',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              _buildSearchBar(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildProductList(all),
                    _buildProductList(all),
                    _buildProductList(all),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: SellerColors.primary,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AddProductScreen()),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Add Product',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  // ═══ Search Bar ═══
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: TextField(
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle:
              const TextStyle(color: SellerColors.subText, fontSize: 14),
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
          enabledBorder: OutlineInputBorder(
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
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
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
            Tab(text: 'Active'),
            Tab(text: 'Out of Stock'),
          ],
        ),
      ),
    );
  }

  // ═══ Product List ═══
  Widget _buildProductList(List<Map<String, dynamic>> all) {
    final list = _filtered(all);

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined,
                size: 64, color: Colors.grey[300]),
            const SizedBox(height: 12),
            const Text(
              'No products found',
              style: TextStyle(
                  color: SellerColors.subText, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
      itemCount: list.length,
      itemBuilder: (context, index) =>
          _productCard(context, list[index].key, list[index].value),
    );
  }

  // ═══ Product Card ═══
  Widget _productCard(BuildContext context, int originalIndex,
      Map<String, dynamic> product) {
    final bool isOutOfStock = product['status'] == 'Out of Stock';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _productImage(product),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] as String? ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: SellerColors.darkText),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['category'] as String? ?? '',
                    style: const TextStyle(
                        color: SellerColors.subText, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        product['price'] as String? ?? '',
                        style: const TextStyle(
                            color: SellerColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isOutOfStock
                              ? Colors.red.withValues(alpha: 0.1)
                              : Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isOutOfStock
                              ? 'Out of Stock'
                              : 'Stock: ${product['stock']}',
                          style: TextStyle(
                              color: isOutOfStock
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProductScreen(
                        product: product,
                        productIndex: originalIndex,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.edit_outlined,
                      color: SellerColors.primary, size: 20),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () =>
                      _deleteDialog(context, originalIndex, product['name']),
                  icon: const Icon(Icons.delete_outline,
                      color: Colors.red, size: 20),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImage(Map<String, dynamic> product) {
    final imagePath = product['imagePath'];
    if (imagePath is String &&
        imagePath.isNotEmpty &&
        File(imagePath).existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(imagePath),
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _fallbackImage(product),
        ),
      );
    }
    return _fallbackImage(product);
  }

  Widget _fallbackImage(Map<String, dynamic> product) {
    final color = product['color'] as Color? ?? SellerColors.primary;
    final icon =
        product['image'] as IconData? ?? Icons.inventory_2_outlined;
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 34),
    );
  }

  // ═══ Delete Dialog ═══
  void _deleteDialog(BuildContext context, int index, String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('Delete Product',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text('Are you sure you want to delete "$name"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: SellerColors.subText)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(80, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.read<ProductProvider>().deleteProduct(index);
            },
            child: const Text('Delete',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
