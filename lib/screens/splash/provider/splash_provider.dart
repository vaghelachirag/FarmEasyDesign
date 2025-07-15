import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final splashProvider = Provider<SplashService>((ref) => SplashService(ref));

class SplashService {
  final Ref ref;
  SplashService(this.ref);

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('isLogin') == "true";
  }

  Future<void> checkPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      await prefs.clear();
      await prefs.setBool('first_run', false);
    }
  }
}
