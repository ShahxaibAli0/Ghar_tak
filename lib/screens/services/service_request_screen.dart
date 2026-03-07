import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/upload_image_box.dart';
import '../../widgets/description_field.dart';

import '../../data/notification_data.dart';
import '../../models/notifications_model.dart';

// OFFERS
import '../../data/dummy_offers_data.dart';
import '../../models/offer_model.dart';

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

  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  final TextEditingController _descriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

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

      body: _buildRequestForm(),
    );
  }

  // IMAGE PICKER

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

  // REQUEST FORM

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
              fontSize: 16,
            ),
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
              fontSize: 16,
            ),
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

                // ADD OFFER REQUEST
                dummyOffers.add(
                  Offer(
                    providerName: "Ali Electrician",
                    serviceName: widget.serviceName,
                    description: _descriptionController.text,
                    price: 500,
                    category: "Electrician",
                    status: "pending",
                    rating: 4.5,
                    completedjobs: 120,
                  ),
                );

                // SUCCESS DIALOG
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {

                    return AlertDialog(

                      title: const Text("Success"),

                      content: Text(
                        "${widget.serviceName} request sent successfully",
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {

                            Navigator.pop(context);
                            Navigator.pop(context);

                          },
                          child: const Text("OK"),
                        ),

                      ],
                    );
                  },
                );

                // ADD NOTIFICATION AFTER 1 MINUTE
                Timer(const Duration(minutes: 1), () {

                  appNotifications.add(
                    NotificationModel(
                      title: "Request Sent",
                      message:
                          "${widget.serviceName} request sent successfully",
                      time:"${DateTime.now().hour}:${DateTime.now().minute}",
                    ),
                  );

                });

              },

              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor:
                    const Color(0xff1E9E6A),

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
}