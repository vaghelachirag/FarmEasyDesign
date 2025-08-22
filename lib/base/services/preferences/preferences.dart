import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_key.dart';

class PreferenceService {
  // Private constructor
  PreferenceService._();

  // Singleton instance
  static final PreferenceService _instance = PreferenceService._();
  static PreferenceService get instance => _instance;

  // Secure storage (encrypted)
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Local storage (non-sensitive values)
  static SharedPreferences? _sharedPreferences;

  /// ✅ Initialize before using
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // ----------------------------
  // Onboarding
  // ----------------------------
  bool get isOnboard =>
      _sharedPreferences?.getBool(_PreferencesKey.onboard) ?? false;

  Future<void> setIsOnboard(bool value) async {
    await _sharedPreferences?.setBool(_PreferencesKey.onboard, value);
  }

  // ----------------------------
  // Login Status
  // ----------------------------
  Future<bool> get isLogin async {
    final value = await safeRead(key: _PreferencesKey.isLogin);
    return value == "true";
  }

  Future<void> setIsLogin(bool value) async {
    await _secureStorage.write(
      key: _PreferencesKey.isLogin,
      value: value.toString(),
    );
  }

  // ----------------------------
  // Access Token
  // ----------------------------
  Future<String?> get accessToken async =>
      await _secureStorage.read(key: _PreferencesKey.accessToken);

  Future<void> setAccessToken(String value) async {
    await _secureStorage.write(key: _PreferencesKey.accessToken, value: value);
  }

  // ----------------------------
  // Refresh Token
  // ----------------------------
  Future<String?> get refreshToken async =>
      await _secureStorage.read(key: _PreferencesKey.refreshToken);

  Future<void> setRefreshToken(String value) async {
    await _secureStorage.write(key: _PreferencesKey.refreshToken, value: value);
  }

  // ----------------------------
  // User SID
  // ----------------------------
  Future<String?> get userSid async =>
      await _secureStorage.read(key: _PreferencesKey.userSid);

  Future<void> setUserSid(String value) async {
    await _secureStorage.write(key: _PreferencesKey.userSid, value: value);
  }

  // ----------------------------
  // User Name
  // ----------------------------
  Future<String?> get userName async =>
      await _secureStorage.read(key: _PreferencesKey.userName);

  Future<void> setUserName(String value) async {
    await _secureStorage.write(key: _PreferencesKey.userName, value: value);
  }

  // ----------------------------
  // User Email
  // ----------------------------
  Future<String?> get userEmail async =>
      await _secureStorage.read(key: _PreferencesKey.userEmail);

  Future<void> setUserEmail(String value) async {
    await _secureStorage.write(key: _PreferencesKey.userEmail, value: value);
  }

  // ----------------------------
  // App Version
  // ----------------------------
  Future<String?> get appVersion async =>
      await _secureStorage.read(key: _PreferencesKey.appVersion);

  Future<void> setAppVersion(String value) async {
    await _secureStorage.write(key: _PreferencesKey.appVersion, value: value);
  }

  // ----------------------------
  // Safe read helper
  // ----------------------------
  Future<String?> safeRead({required String key}) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      debugPrint('Decryption error: $e');
      await _secureStorage.delete(key: key); // delete only corrupted key
      return null;
    }
  }

  // ----------------------------
  // Clear All
  // ----------------------------
  Future<void> clearPreferences() async {
    await _secureStorage.deleteAll();
    await _sharedPreferences?.clear();
  }
}
