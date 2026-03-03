import 'package:flutter/material.dart';

class SendRequestButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SendRequestButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize:
            const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15),
        ),
      ),
      onPressed: onPressed,
      child: const Text(
        "Send Request",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}