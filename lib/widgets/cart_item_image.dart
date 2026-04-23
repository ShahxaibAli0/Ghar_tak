import 'dart:io';

import 'package:flutter/material.dart';

class CartItemImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;

  const CartItemImage({
    super.key,
    required this.imagePath,
    this.width = 65,
    this.height = 65,
    this.borderRadius = 8,
  });

  bool get _isNetworkImage =>
      imagePath.startsWith('http://') || imagePath.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (_isNetworkImage) {
      return Image.network(
        imagePath,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallback(),
      );
    }

    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      return Image.file(
        File(imagePath),
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallback(),
      );
    }

    return _fallback();
  }

  Widget _fallback() {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.shade200,
      child: const Icon(
        Icons.shopping_bag_outlined,
        color: Colors.grey,
        size: 30,
      ),
    );
  }
}
