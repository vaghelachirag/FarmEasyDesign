import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = Provider<LoginService>((ref) => LoginService(ref));

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final isLoadingProvider = StateProvider<bool>((ref) => false);
final rememberMeProvider = StateProvider<bool>((ref) => false);
final isPassHideProvider = StateProvider<bool>((ref) => true);



final isLoginEnabledProvider = Provider<bool>((ref) {
  final email = ref.watch(emailProvider);
  final password = ref.watch(passwordProvider);
  return email.isNotEmpty && password.length >= 6;
});

class LoginService {
  final Ref ref;
  LoginService(this.ref);

}
