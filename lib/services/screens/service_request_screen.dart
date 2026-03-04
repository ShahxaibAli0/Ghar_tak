import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/offer_model.dart';
import '../widgets/upload_image_box.dart';
import '../widgets/description_field.dart';
import '../widgets/offer_card.dart';

class ServiceRequestScreen extends StatefulWidget {
  final String serviceName;

  const ServiceRequestScreen({
    Key? key,
    required this.serviceName,
  }) : super(key: key);

  @override
  State<ServiceRequestScreen> createState() =>
      _ServiceRequestScreenState();
}

class _ServiceRequestScreenState
    extends State<ServiceRequestScreen> {

  bool requestSent = false;
  bool jobAccepted = false;

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _descriptionController =
      TextEditingController();

  final List<OfferModel> offers = [
    OfferModel(providerName: "Ali Electric Works", price: "Rs. 1500"),
    OfferModel(providerName: "Ahmed Services", price: "Rs. 1300"),
    OfferModel(providerName: "Khan Electrician", price: "Rs. 1400"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🔥 White Background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.serviceName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: jobAccepted
            ? _buildSuccessSection()
            : requestSent
                ? _buildOffersSection()
                : _buildRequestForm(),
      ),
    );
  }

  // ================= IMAGE PICKER =================

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Camera"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Gallery"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  // ================= REQUEST FORM =================

  Widget _buildRequestForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Upload Problem Image",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),

          const SizedBox(height: 12),

          UploadImageBox(
            image: selectedImage,
            onTap: _showImageSourceSheet,
          ),

          const SizedBox(height: 30),

          const Text(
            "Describe Your Problem",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),

          const SizedBox(height: 12),

          DescriptionField(
            controller: _descriptionController,
          ),

          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                if (_descriptionController.text
                    .trim()
                    .isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Please describe your problem"),
                    ),
                  );
                  return;
                }

                setState(() {
                  requestSent = true;
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xff1E9E6A),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                "Send Service Request",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= OFFERS =================

  Widget _buildOffersSection() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [

        const Text(
          "Offers from Providers",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 25),

        ...offers.map(
          (offer) => Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: OfferCard(
              offer: offer,
              onAccept: _showConfirmationDialog,
            ),
          ),
        ),
      ],
    );
  }

  // ================= CONFIRMATION =================

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18),
        ),
        title: const Text("Confirm Service"),
        content: const Text(
            "Do you want to accept this offer?"),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                jobAccepted = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xff1E9E6A),
            ),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  // ================= SUCCESS =================

  Widget _buildSuccessSection() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xff1E9E6A),
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            "Service Confirmed!",
            style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
              "Your ${widget.serviceName} is on the way."),
        ],
      ),
    );
  }
}