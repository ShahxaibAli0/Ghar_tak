import 'package:shared_preferences/shared_preferences.dart';

enum AppEntryMode { buyer, seller }

class AppEntryPreference {
  static const _preferredModeKey = 'preferred_app_entry_mode';

  static Future<void> setBuyerMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_preferredModeKey, AppEntryMode.buyer.name);
  }

  static Future<void> setSellerMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_preferredModeKey, AppEntryMode.seller.name);
  }

  static Future<AppEntryMode?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_preferredModeKey);

    switch (value) {
      case 'buyer':
        return AppEntryMode.buyer;
      case 'seller':
        return AppEntryMode.seller;
      default:
        return null;
    }
  }
}
