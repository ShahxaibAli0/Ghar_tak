import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/offer_provider.dart';
import 'providers/product_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/home/home_screen.dart';
import 'seller/auth/become_vendor_screen.dart';
import 'seller/splash/seller_splash_screen.dart';
import 'seller/widgets/seller_bottom_nav.dart';

void main() {
  runApp(const GharTakApp());
}

class GharTakApp extends StatelessWidget {
  const GharTakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OfferProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ghar Tak',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.green.shade50,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
        initialRoute: '/splash',
        routes: {
          // ── Core ──
          '/splash':  (context) => const SplashScreen(),
          '/login':   (context) => const LoginScreen(),
          '/signup':  (context) => const SignupScreen(),
          '/home':    (context) => const HomeScreen(),
          // ── Seller ──
          '/seller-splash': (context) => const SellerSplashScreen(),
          '/seller-home':   (context) => const SellerBottomNav(),
          '/become-vendor': (context) => const BecomeVendorScreen(),
        },
      ),
    );
  }
}
