import 'package:flutter/material.dart';
import 'order_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "Cash on Delivery";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Select Payment Method"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            paymentTile("Cash on Delivery", Icons.money),
            paymentTile("JazzCash", Icons.account_balance_wallet),
            paymentTile("EasyPaisa", Icons.phone_android),

            Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderSuccessScreen()),
                  );
                },
                child: Text(
                  "Confirm Payment",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentTile(String title, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: RadioListTile(
        value: title,
        groupValue: selectedMethod,
        activeColor: Colors.green,
        onChanged: (value) {
          setState(() {
            selectedMethod = value.toString();
          });
        },
        title: Text(title),
        secondary: Icon(icon, color: Colors.green),
      ),
    );
  }
}