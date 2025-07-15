import 'package:farmeasy/base/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final themeProvider = AsyncNotifierProvider<ThemeNotifier, String>(
  ThemeNotifier.new,
);

class ThemeNotifier extends AsyncNotifier<String> {
  final _storage = const FlutterSecureStorage();

  @override
  Future<String> build() async {
    // This is equivalent to initializeThemeMode
    final savedTheme = await _storage.read(key: AppStrings.theme);
    return savedTheme ?? AppStrings.systemTheme;
  }

  ThemeMode get themeMode {
    final current = state.value ?? AppStrings.systemTheme;
    if (current == AppStrings.lightTheme) {
      return ThemeMode.light;
    } else if (current == AppStrings.darkTheme) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  Future<void> changeTheme(String theme) async {
    await _storage.write(key: AppStrings.theme, value: theme);
    state = AsyncData(theme);
  }
}
