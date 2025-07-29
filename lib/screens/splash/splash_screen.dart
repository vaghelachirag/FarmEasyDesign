import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/screens/splash/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../generator/assets.gen.dart';
import '../login/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const route = "/SplashScreen";

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    handleSplash();
  }

  Future<void> handleSplash() async {
    final splashService = ref.read(splashProvider);
    await Future.delayed(const Duration(seconds: 2));
    if (await splashService.isLoggedIn()) {
    } else {
      context.navigator.pushReplacementNamed(LoginScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body:Center(
        child: Assets.images.splashLogo.image(
          width: 200,
          height: 200,
          fit: BoxFit.fitWidth,
        )
      ),
    );
  }
}
