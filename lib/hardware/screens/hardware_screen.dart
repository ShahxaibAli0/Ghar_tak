import 'package:flutter/material.dart';
import '../data/hardware_data.dart';
import 'hardware_stores_screen.dart';

class HardwareScreen extends StatelessWidget {
  const HardwareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HardwareStoresScreen(stores: hardwareStores);
  }
}