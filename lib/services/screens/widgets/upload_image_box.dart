import 'dart:io';
import 'package:flutter/material.dart';

class UploadImageBox extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  const UploadImageBox({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: image == null
            ? const Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.green,
                ),
              )
            : ClipRRect(
                borderRadius:
                    BorderRadius.circular(20),
                child: Image.file(
                  image!,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}