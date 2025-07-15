import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_key.dart';

class PreferenceService {
  // Private constructor
  PreferenceService._();

  // The single instance of PreferenceService
  static final PreferenceService _instance = PreferenceService._();

  // Getter to access the instance
  static PreferenceService get instance => _instance;

  static const FlutterSecureStorage _preferences = FlutterSecureStorage();

  static SharedPreferences? _sharedPreferences;

  // initialise
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// onboard
  bool get isOnboard =>
      _sharedPreferences?.getBool(_PreferencesKey.onboard) ?? false;

  setIsOnboard(bool value) async {
    await _sharedPreferences?.setBool(_PreferencesKey.onboard, value);
  }

  /// login status
  Future<String?> get isLogin async =>
      await safeRead(key: _PreferencesKey.isLogin) ?? "false";

  Future<void> setIsLogin(String value) async {
    await _preferences.write(key: _PreferencesKey.isLogin, value: value);
  }

  Future<String?> safeRead({required String key}) async {
    try {
      return await _preferences.read(key: key);
    } catch (e) {
      debugPrint('Decryption error: $e');
      await _preferences.deleteAll(); // delete corrupted entry
      return null;
    }
  }

  /// access token
  Future<String?> get accessToken async =>
      await _preferences.read(key: _PreferencesKey.accessToken);

  Future<void> setAccessToken(String value) async {
    await _preferences.write(key: _PreferencesKey.accessToken, value: value);
  }

  /// refresh token
  Future<String?> get refreshToken async =>
      await _preferences.read(key: _PreferencesKey.refreshToken);

  Future<void> setRefreshToken(String value) async {
    await _preferences.write(key: _PreferencesKey.refreshToken, value: value);
  }

  /// user sid
  Future<String?> get userSid async =>
      await _preferences.read(key: _PreferencesKey.userSid);

  Future<void> setUserSid(String value) async {
    await _preferences.write(key: _PreferencesKey.userSid, value: value);
  }

  /// user name
  Future<String?> get userName async =>
      await _preferences.read(key: _PreferencesKey.userName);

  Future<void> setUserName(String value) async {
    await _preferences.write(key: _PreferencesKey.userName, value: value);
  }

  /// user email
  Future<String?> get userEmail async =>
      await _preferences.read(key: _PreferencesKey.userEmail);

  Future<void> setUserEmail(String value) async {
    await _preferences.write(key: _PreferencesKey.userEmail, value: value);
  }

  /// app version
  Future<String?> get appVersion async =>
      await _preferences.read(key: _PreferencesKey.appVersion);

  Future<void> setAppVersion(String value) async {
    await _preferences.write(key: _PreferencesKey.appVersion, value: value);
  }

  /// clear preference
  Future<void> clearPreferences() async {
    await _preferences.deleteAll();
  }
}
