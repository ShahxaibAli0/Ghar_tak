import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/app_entry_preference.dart';
import '../shop/seller_shop_profile_store.dart';

class SellerAuthStore {
  static const _sessionKey = 'seller_is_logged_in';
  static const _rememberMeKey = 'seller_remember_me';
  static const _userRecordKey = 'seller_auth_user_record';
  static const _rememberedCredentialsKey = 'seller_auth_remembered_credentials';
  static const _legacyPasswordKey = 'seller_password';

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<bool> hasAccount() async {
    final user = await _readUserRecord();
    return user != null && (user['email'] ?? '').isNotEmpty;
  }

  static Future<void> signup({
    required String shopName,
    required String ownerName,
    required String email,
    String? phone,
    required String cnic,
    required String category,
    required String password,
    bool rememberMe = false,
  }) async {
    final user = {
      'shopName': shopName.trim(),
      'ownerName': ownerName.trim(),
      'email': email.trim(),
      'phone': phone?.trim() ?? '',
      'cnic': cnic.trim(),
      'category': category.trim(),
      'password': password,
    };

    final prefs = await SharedPreferences.getInstance();
    await _writeSecureJson(_userRecordKey, user);
    await _secureStorage.write(key: _legacyPasswordKey, value: password);
    await prefs.setBool(_sessionKey, false);

    if (rememberMe) {
      await _saveRememberedCredentials(
          email: user['email']!, password: password);
    } else {
      await _clearRememberedCredentials();
    }

    await SellerShopProfileStore.seedFromRegistration(
      shopName: user['shopName']!,
      sellerEmail: user['email']!,
    );
    await AppEntryPreference.setSellerMode();
  }

  static Future<String?> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final user = await _readUserRecord();

    if (user == null || (user['email'] ?? '').isEmpty) {
      return 'No seller account found. Please create one first.';
    }

    final savedEmail = (user['email'] ?? '').trim().toLowerCase();
    if (email.trim().toLowerCase() != savedEmail) {
      return 'Email not recognised.';
    }

    if (password != user['password']) {
      return 'Incorrect password.';
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sessionKey, rememberMe);

    if (rememberMe) {
      await _saveRememberedCredentials(
          email: user['email']!, password: password);
    } else {
      await _clearRememberedCredentials();
    }

    await SellerShopProfileStore.seedFromRegistration(
      shopName: user['shopName'] ?? SellerShopProfileStore.defaultShopName,
      sellerEmail: user['email']!,
    );
    await AppEntryPreference.setSellerMode();
    return null;
  }

  static Future<Map<String, String>?> loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    if (!rememberMe) {
      return null;
    }

    final saved = await _readSecureJson(_rememberedCredentialsKey);
    if (saved == null) {
      return null;
    }

    final email = saved['email'] ?? '';
    final password = saved['password'] ?? '';
    if (email.isEmpty || password.isEmpty) {
      return null;
    }

    return {
      'email': email,
      'password': password,
    };
  }

  static Future<bool> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool(_sessionKey) ?? false;
    if (!loggedIn) {
      return false;
    }

    final user = await _readUserRecord();
    if (user == null || (user['email'] ?? '').isEmpty) {
      await prefs.setBool(_sessionKey, false);
      return false;
    }

    await AppEntryPreference.setSellerMode();
    await SellerShopProfileStore.seedFromRegistration(
      shopName: user['shopName'] ?? SellerShopProfileStore.defaultShopName,
      sellerEmail: user['email']!,
    );
    return true;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sessionKey, false);
    await AppEntryPreference.setSellerMode();
  }

  static Future<String?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = await _readUserRecord();
    if (user == null || (user['email'] ?? '').isEmpty) {
      return 'No seller account found. Please create one first.';
    }

    if ((user['password'] ?? '') != currentPassword) {
      return 'Current password is incorrect.';
    }

    user['password'] = newPassword;
    await _writeSecureJson(_userRecordKey, user);
    await _secureStorage.write(key: _legacyPasswordKey, value: newPassword);

    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    if (rememberMe) {
      await _saveRememberedCredentials(
        email: user['email']!,
        password: newPassword,
      );
    }

    return null;
  }

  static Future<Map<String, String>?> _readUserRecord() {
    return _readSecureJson(_userRecordKey);
  }

  static Future<void> _saveRememberedCredentials({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, true);
    await _writeSecureJson(_rememberedCredentialsKey, {
      'email': email.trim(),
      'password': password,
    });
  }

  static Future<void> _clearRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, false);
    await _secureStorage.delete(key: _rememberedCredentialsKey);
  }

  static Future<void> _writeSecureJson(
    String key,
    Map<String, String> value,
  ) {
    return _secureStorage.write(
      key: key,
      value: jsonEncode(value),
    );
  }

  static Future<Map<String, String>?> _readSecureJson(String key) async {
    final raw = await _secureStorage.read(key: key);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      return decoded.map(
        (entryKey, value) => MapEntry(entryKey, value?.toString() ?? ''),
      );
    } catch (_) {
      return null;
    }
  }
}
