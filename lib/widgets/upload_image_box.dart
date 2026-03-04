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
        height: 110, // 🔹 smaller height
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // 🔹 less rounded
          border: Border.all(
            color: Colors.green.shade200,
            width: 1,
          ),
        ),
        child: image == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.camera_alt,
                    size: 24,
                    color: Colors.green,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Upload Image",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  image!,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}