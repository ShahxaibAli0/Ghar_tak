import 'package:shared_preferences/shared_preferences.dart';

class SellerShopProfile {
  final String shopName;
  final String shopDescription;
  final String sellerEmail;
  final String? logoPath;
  final String? bannerPath;

  const SellerShopProfile({
    required this.shopName,
    required this.shopDescription,
    required this.sellerEmail,
    this.logoPath,
    this.bannerPath,
  });
}

class SellerShopProfileStore {
  static const shopNameKey = 'seller_shop_name';
  static const shopLogoKey = 'seller_shop_logo_path';
  static const shopDescriptionKey = 'seller_shop_description';
  static const shopBannerKey = 'seller_shop_banner_path';
  static const sellerEmailKey = 'seller_email';

  static const defaultShopName = 'Ahmed Electronics';
  static const defaultShopDescription =
      'Best electronics shop in Karachi. Quality products at best prices.';
  static const defaultSellerEmail = 'ahmed@gmail.com';

  static const fallbackProfile = SellerShopProfile(
    shopName: defaultShopName,
    shopDescription: defaultShopDescription,
    sellerEmail: defaultSellerEmail,
  );

  static Future<SellerShopProfile> load() async {
    final prefs = await SharedPreferences.getInstance();

    return SellerShopProfile(
      shopName: _normalizeText(
            prefs.getString(shopNameKey),
            fallback: defaultShopName,
          ) ??
          defaultShopName,
      shopDescription: _normalizeText(
            prefs.getString(shopDescriptionKey),
            fallback: defaultShopDescription,
          ) ??
          defaultShopDescription,
      sellerEmail: _normalizeText(
            prefs.getString(sellerEmailKey),
            fallback: defaultSellerEmail,
          ) ??
          defaultSellerEmail,
      logoPath: _normalizePath(prefs.getString(shopLogoKey)),
      bannerPath: _normalizePath(prefs.getString(shopBannerKey)),
    );
  }

  static Future<void> saveProfile({
    required String shopName,
    required String shopDescription,
    required String logoPath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(shopNameKey, shopName.trim());
    await prefs.setString(shopDescriptionKey, shopDescription.trim());
    await prefs.setString(shopLogoKey, logoPath.trim());
  }

  static Future<void> saveBanner(String bannerPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(shopBannerKey, bannerPath.trim());
  }

  static Future<void> saveSellerEmail(String email) async {
    final normalizedEmail = email.trim();
    if (normalizedEmail.isEmpty) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(sellerEmailKey, normalizedEmail);
  }

  static Future<void> seedFromRegistration({
    required String shopName,
    required String sellerEmail,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final normalizedShopName = shopName.trim();
    final normalizedEmail = sellerEmail.trim();

    if (normalizedShopName.isNotEmpty) {
      await prefs.setString(shopNameKey, normalizedShopName);
    }
    if (normalizedEmail.isNotEmpty) {
      await prefs.setString(sellerEmailKey, normalizedEmail);
    }
  }

  static String? _normalizeText(String? value, {String? fallback}) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return fallback;
    }
    return trimmed;
  }

  static String? _normalizePath(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
