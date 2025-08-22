import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../base/services/preferences/preferences.dart';

final splashProvider = Provider<SplashService>((ref) {
  return SplashService(ref, PreferenceService.instance,);
});

class SplashService {
  final Ref ref;
  final PreferenceService preferences;

  SplashService(this.ref, this.preferences);

  Future<bool> isLoggedIn() async {
    return await preferences.isLogin;
  }

}
