import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _products = [];

  List<Map<String, dynamic>> get products => List.unmodifiable(_products);

  // Returns only Active products for a given category (for user-facing screens)
  List<Map<String, dynamic>> byCategory(String category) => _products
      .where((p) =>
          p['category'] == category && p['status'] == 'Active')
      .toList();

  ProductProvider() {
    _loadProducts();
  }

  // ── Persistence ───────────────────────────────────────────

  Future<void> _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('seller_products') ?? '[]';
    final list = json.decode(jsonStr) as List;
    _products = list
        .map((e) => _withIconAndColor(Map<String, dynamic>.from(e as Map)))
        .toList();
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    // Strip non-serializable fields before saving
    final serializable = _products.map(_toJson).toList();
    await prefs.setString('seller_products', json.encode(serializable));
  }

  // ── CRUD ──────────────────────────────────────────────────

  Future<void> addProduct(Map<String, dynamic> product) async {
    _products.insert(0, _withIconAndColor(product));
    await _save();
    notifyListeners();
  }

  Future<void> updateProduct(int index, Map<String, dynamic> updated) async {
    _products[index] = _withIconAndColor(updated);
    await _save();
    notifyListeners();
  }

  Future<void> deleteProduct(int index) async {
    _products.removeAt(index);
    await _save();
    notifyListeners();
  }

  // ── Helpers ───────────────────────────────────────────────

  // Strips Color and IconData (not JSON-safe); stores category as key
  Map<String, dynamic> _toJson(Map<String, dynamic> p) {
    final map = Map<String, dynamic>.from(p);
    map.remove('image');
    map.remove('color');
    return map;
  }

  // Reconstructs image / color from category after loading from JSON
  Map<String, dynamic> _withIconAndColor(Map<String, dynamic> p) {
    final category = p['category'] as String? ?? '';
    return {
      ...p,
      'image': _iconForCategory(category),
      'color': _colorForCategory(category),
    };
  }

  static IconData _iconForCategory(String category) {
    switch (category) {
      case 'Grocery':
        return Icons.local_grocery_store;
      case 'Hardware':
        return Icons.hardware;
      case 'Electric':
        return Icons.electrical_services;
      case 'Restaurant':
        return Icons.restaurant;
      case 'Pharmacies':
        return Icons.medication;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  static Color _colorForCategory(String category) {
    switch (category) {
      case 'Grocery':
        return Colors.green;
      case 'Hardware':
        return Colors.blueGrey;
      case 'Electric':
        return Colors.amber;
      case 'Restaurant':
        return Colors.deepOrange;
      case 'Pharmacies':
        return Colors.red;
      default:
        return const Color(0xFF0E9F6E);
    }
  }
}
