import 'package:flutter/material.dart';
import 'shop_info_screen.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  InputDecoration fieldDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.green),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Vendor Setup"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              // Step Indicator
              Row(
                children: [
                  _stepCircle("1", true),
                  _line(),
                  _stepCircle("2", false),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Enter your details to continue",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // Card Container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black12,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [

                    TextField(
                      controller: nameController,
                      decoration: fieldDecoration("Full Name", Icons.person),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: emailController,
                      decoration: fieldDecoration("Email", Icons.email),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: phoneController,
                      decoration: fieldDecoration("Phone", Icons.phone),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: fieldDecoration("Password", Icons.lock),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ShopInfoScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _stepCircle(String text, bool active) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: active ? Colors.green : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _line() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey.shade300,
      ),
    );
  }
}