import 'package:farmeasy/base/utils/routes.dart';
import 'package:farmeasy/screens/homeTab/home_tab.dart';
import 'package:farmeasy/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base/providers/theme_provider.dart';
import 'base/services/preferences/preferences.dart';
import 'base/utils/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'base/utils/global_context.dart';
import 'base/utils/theme.dart';
import 'generated/l10n.dart';
import 'screens/splash/splash_screen.dart';

void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceService.instance.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider); // AsyncValue<String>
    final themeNotifier = ref.read(themeProvider.notifier);

    // Wait for theme to load
    if (themeState.isLoading || themeState.hasError) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    ScreenUtil.init(context);

    return GestureDetector(
      onTap: closeKeyboard,
      child: MaterialApp(
        title: 'Farmeasy',
        themeMode: themeNotifier.themeMode,
        theme: lightTheme(),
        darkTheme: darkThemeData(),
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.route: (context) => LoginScreen(),
        },
        navigatorKey: NavigationService.navigatorKey,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: AppRoute.onGeneratedRoute,
        initialRoute: HomeTab.route,
      ),
    );
  }
}
