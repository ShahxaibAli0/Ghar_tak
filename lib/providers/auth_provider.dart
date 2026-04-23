import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/app_entry_preference.dart';

class AuthProvider extends ChangeNotifier {
  static const String _sessionKey = 'isLoggedIn';
  static const String _rememberMeKey = 'rememberMe';
  static const String _userRecordKey = 'auth_user_record';
  static const String _rememberedCredentialsKey = 'auth_remembered_credentials';

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  bool _isLoggedIn = false;
  String _userName = '';
  String _userEmail = '';
  String _userPhone = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;

  Future<bool> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool(_sessionKey) ?? false;
    if (!loggedIn) return false;

    final user = await _readUserRecord(prefs);
    if (user == null) {
      await prefs.setBool(_sessionKey, false);
      return false;
    }

    _setCurrentUser(user, loggedIn: true);
    notifyListeners();
    return true;
  }

  Future<void> signup({
    required String name,
    required String email,
    String? phone,
    required String password,
    bool rememberMe = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final user = {
      'name': name.trim(),
      'email': email.trim(),
      'phone': phone?.trim() ?? '',
      'password': password,
    };

    await _writeSecureJson(_userRecordKey, user);
    await prefs.setString('userName', user['name']!);
    await prefs.setString('userEmail', user['email']!);
    await prefs.setString('userPhone', user['phone']!);
    await prefs.remove('userPassword');
    await prefs.setBool(_sessionKey, rememberMe);

    if (rememberMe) {
      await _saveRememberedCredentials(
        email: user['email']!,
        password: password,
      );
    } else {
      await _clearRememberedCredentials();
    }

    await AppEntryPreference.setBuyerMode();
    _setCurrentUser(user, loggedIn: rememberMe);
    notifyListeners();
  }

  Future<String?> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final user = await _readUserRecord(prefs);

    if (user == null || (user['email'] ?? '').isEmpty) {
      return 'No account found. Please sign up first.';
    }
    if (email.trim().toLowerCase() != user['email']!.toLowerCase()) {
      return 'Email not recognised.';
    }
    if (password != user['password']) {
      return 'Incorrect password.';
    }

    await prefs.setBool(_sessionKey, rememberMe);
    if (rememberMe) {
      await _saveRememberedCredentials(
        email: user['email']!,
        password: password,
      );
    } else {
      await _clearRememberedCredentials();
    }

    await AppEntryPreference.setBuyerMode();
    _setCurrentUser(user, loggedIn: true);
    notifyListeners();
    return null;
  }

  Future<Map<String, String>?> loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    if (!rememberMe) return null;

    final saved = await _readSecureJson(_rememberedCredentialsKey);
    if (saved != null &&
        (saved['email'] ?? '').isNotEmpty &&
        (saved['password'] ?? '').isNotEmpty) {
      return {
        'email': saved['email']!,
        'password': saved['password']!,
      };
    }

    final legacyEmail = prefs.getString('rememberedEmail') ?? '';
    final legacyPassword = prefs.getString('rememberedPassword') ?? '';
    if (legacyEmail.isEmpty || legacyPassword.isEmpty) return null;

    await _saveRememberedCredentials(
      email: legacyEmail,
      password: legacyPassword,
    );
    await prefs.remove('rememberedEmail');
    await prefs.remove('rememberedPassword');

    return {
      'email': legacyEmail,
      'password': legacyPassword,
    };
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sessionKey, false);
    _isLoggedIn = false;
    _userName = '';
    _userEmail = '';
    _userPhone = '';
    notifyListeners();
  }

  Future<Map<String, String>?> _readUserRecord(
    SharedPreferences prefs,
  ) async {
    final user = await _readSecureJson(_userRecordKey);
    if (user != null) return user;

    final legacyEmail = prefs.getString('userEmail') ?? '';
    final legacyPassword = prefs.getString('userPassword') ?? '';
    if (legacyEmail.isEmpty || legacyPassword.isEmpty) return null;

    final legacyUser = {
      'name': prefs.getString('userName') ?? '',
      'email': legacyEmail,
      'phone': prefs.getString('userPhone') ?? '',
      'password': legacyPassword,
    };

    await _writeSecureJson(_userRecordKey, legacyUser);
    await prefs.remove('userPassword');
    return legacyUser;
  }

  Future<void> _saveRememberedCredentials({
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

  Future<void> _clearRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, false);
    await _secureStorage.delete(key: _rememberedCredentialsKey);
    await prefs.remove('rememberedEmail');
    await prefs.remove('rememberedPassword');
  }

  Future<void> _writeSecureJson(
    String key,
    Map<String, String> value,
  ) {
    return _secureStorage.write(
      key: key,
      value: jsonEncode(value),
    );
  }

  Future<Map<String, String>?> _readSecureJson(String key) async {
    final raw = await _secureStorage.read(key: key);
    if (raw == null || raw.isEmpty) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;

      return decoded.map(
        (key, value) => MapEntry(key, value?.toString() ?? ''),
      );
    } catch (_) {
      return null;
    }
  }

  void _setCurrentUser(
    Map<String, String> user, {
    required bool loggedIn,
  }) {
    _isLoggedIn = loggedIn;
    _userName = user['name'] ?? '';
    _userEmail = user['email'] ?? '';
    _userPhone = user['phone'] ?? '';
  }
}
