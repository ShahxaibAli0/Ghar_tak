import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/offer_model.dart';
import '../widgets/upload_image_box.dart';
import '../widgets/description_field.dart';
import '../widgets/send_request_button.dart';
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

  // Dummy offers list
  final List<OfferModel> offers = [
    OfferModel(
        providerName: "Ali Electric Works",
        price: "Rs. 1500"),
    OfferModel(
        providerName: "Ahmed Services",
        price: "Rs. 1300"),
    OfferModel(
        providerName: "Khan Electrician",
        price: "Rs. 1400"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("${widget.serviceName} Service"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Upload Problem Image",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),

        const SizedBox(height: 10),

        UploadImageBox(
          image: selectedImage,
          onTap: _showImageSourceSheet,
        ),

        const SizedBox(height: 25),

        const Text(
          "Describe Your Problem",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),

        const SizedBox(height: 10),

        DescriptionField(
          controller: _descriptionController,
        ),

        const SizedBox(height: 25),

        SendRequestButton(
          onPressed: () {
            if (_descriptionController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please describe your problem"),
                ),
              );
              return;
            }

            setState(() {
              requestSent = true;
            });
          },
        ),
      ],
    );
  }

  // ================= OFFERS SECTION =================

  Widget _buildOffersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Offers from Providers",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        ...offers.map(
          (offer) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
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
        title: const Text("Confirm Service"),
        content:
            const Text("Do you want to accept this offer?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                jobAccepted = true;
              });
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  // ================= SUCCESS SCREEN =================

  Widget _buildSuccessSection() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 80),
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            "Service Confirmed!",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
              "Your ${widget.serviceName} is on the way."),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              setState(() {
                jobAccepted = false;
                requestSent = false;
                _descriptionController.clear();
                selectedImage = null;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text("Back"),
          )
        ],
      ),
    );
  }
}