import 'dart:io';

import 'package:flutter/material.dart';
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

  final List<Map<String, dynamic>> products = [
    {
      'name': 'LED Bulb 12W',
      'category': 'Electric',
      'price': 'Rs. 350',
      'stock': 45,
      'status': 'Active',
      'image': Icons.lightbulb,
      'color': Colors.yellow,
    },
    {
      'name': 'PVC Pipe 1 inch',
      'category': 'Hardware',
      'price': 'Rs. 120',
      'stock': 0,
      'status': 'Out of Stock',
      'image': Icons.plumbing,
      'color': Colors.grey,
    },
    {
      'name': 'Panadol 10 Tabs',
      'category': 'Pharmacies',
      'price': 'Rs. 80',
      'stock': 200,
      'status': 'Active',
      'image': Icons.medication,
      'color': Colors.red,
    },
    {
      'name': 'Basmati Rice 5kg',
      'category': 'Grocery',
      'price': 'Rs. 1,200',
      'stock': 30,
      'status': 'Active',
      'image': Icons.rice_bowl,
      'color': Colors.brown,
    },
    {
      'name': 'Wood Screw Set',
      'category': 'Hardware',
      'price': 'Rs. 250',
      'stock': 0,
      'status': 'Out of Stock',
      'image': Icons.handyman,
      'color': Colors.blueGrey,
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

  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> list = products;

    if (_tabController.index == 1) {
      list = list.where((p) => p['status'] == 'Active').toList();
    } else if (_tabController.index == 2) {
      list = list.where((p) => p['status'] == 'Out of Stock').toList();
    }

    if (_searchQuery.isNotEmpty) {
      list = list
          .where((p) => p['name']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: SellerColors.primary,
        elevation: 0,
        toolbarHeight: 86,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          tooltip: 'Back',
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
                fontWeight: FontWeight.bold,
              ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${products.length} Products',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
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
                _buildProductList(),
                _buildProductList(),
                _buildProductList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: SellerColors.primary,
        onPressed: _openAddProduct,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _openAddProduct() async {
    final product = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const AddProductScreen()),
    );

    if (!mounted || product == null) return;

    setState(() => products.insert(0, product));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text('Product added to inventory'),
          ],
        ),
        backgroundColor: SellerColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          hintText: 'Search products...',
          hintStyle: const TextStyle(color: SellerColors.subText, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: SellerColors.primary),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: SellerColors.subText),
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
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
  Widget _buildProductList() {
    final list = _filteredProducts;

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 12),
            const Text(
              'No products found',
              style: TextStyle(color: SellerColors.subText, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
      itemCount: list.length,
      itemBuilder: (context, index) => _productCard(context, list[index]),
    );
  }

  // ═══ Product Card ═══
  Widget _productCard(BuildContext context, Map<String, dynamic> product) {
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
            // ── Product Image ──
            _productImage(product),
            const SizedBox(width: 14),

            // ── Product Info ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: SellerColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['category'],
                    style: const TextStyle(
                      color: SellerColors.subText,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        product['price'],
                        style: const TextStyle(
                          color: SellerColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
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
                            color: isOutOfStock ? Colors.red : Colors.green,
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

            // ── Edit + Delete Buttons ──
            Column(
              children: [
                // ✅ Edit Button — EditProductScreen pe jata hai
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProductScreen(product: product),
                    ),
                  ),
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: SellerColors.primary,
                    size: 20,
                  ),
                  tooltip: 'Edit',
                ),

                // ✅ Delete Button — Dialog dikhata hai
                IconButton(
                  onPressed: () => _deleteDialog(product['name']),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 20,
                  ),
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
          errorBuilder: (_, __, ___) => _fallbackProductImage(product),
        ),
      );
    }

    return _fallbackProductImage(product);
  }

  Widget _fallbackProductImage(Map<String, dynamic> product) {
    final color = product['color'] as Color? ?? SellerColors.primary;
    final icon = product['image'] as IconData? ?? Icons.inventory_2_outlined;

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
  void _deleteDialog(String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
