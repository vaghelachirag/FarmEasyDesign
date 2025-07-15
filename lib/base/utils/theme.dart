import 'package:farmeasy/generator/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    // fontFamily: FontFamily.raleway,
    appBarTheme: appBarTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    splashColor: AppColors.white,
    hoverColor: AppColors.white,
    colorScheme: _colorScheme,
    highlightColor: AppColors.white,
    textTheme: TextTheme(
      labelSmall: TextStyle(
        fontSize: 11.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        fontWeight: FontWeight.w400,
        color: AppColors.textColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 13.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 15.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 20.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      displayMedium: TextStyle(
        fontSize: 26.sp,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      displayLarge: TextStyle(
        fontSize: 28.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 30.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 32.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 34.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.textColor,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: AppColors.slateGray),
      ),
      checkColor: WidgetStatePropertyAll(_colorScheme.surface),
      visualDensity: VisualDensity.compact,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: AppColors.black16,
      selectedIconTheme: IconThemeData(color: AppColors.navBarColor),
      unselectedItemColor: AppColors.navBarUnselectedColor,
      unselectedLabelStyle: TextStyle(
        color: AppColors.navBarUnselectedColor,
        fontSize: 10.sp,
        // letterSpacing: .2,
        fontFamily: FontFamily.roboto,
      ),
      selectedLabelStyle: TextStyle(
        color: AppColors.navBarUnselectedColor,
        fontSize: 11.sp,
        // letterSpacing: .7,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
      ),
      type: BottomNavigationBarType.fixed,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.navBarUnselectedColor),
      radius: const Radius.circular(10),
      thumbVisibility: WidgetStateProperty.all(true),
      trackVisibility: WidgetStateProperty.all(true),
    ),
    useMaterial3: true,
  );
}

ThemeData darkThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkScaffoldColor,
    // fontFamily: FontFamily.raleway,
    fontFamily: FontFamily.roboto,
    textTheme: TextTheme(
      labelSmall: TextStyle(
        fontSize: 11.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      bodySmall: TextStyle(
        fontSize: 13.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 15.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      labelLarge: TextStyle(
        fontSize: 20.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      displayMedium: TextStyle(
        fontSize: 26.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      displayLarge: TextStyle(
        fontSize: 28.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 30.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 32.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 34.sp,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
        color: AppColors.darkTextColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.blackColor,
      scrolledUnderElevation: 0.0,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.darkTextColor),
      titleTextStyle: TextStyle(
        color: AppColors.darkTextColor,
        fontSize: 14,
        letterSpacing: 1,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.roboto,
        // fontFamily: FontFamily.raleway,
      ),
    ),
  );
}

final ColorScheme _colorScheme = ColorScheme(
  primary: AppColors.primary,
  onPrimary: Colors.black,
  brightness: Brightness.light,
  surface: AppColors.white,
  secondary: Colors.deepOrangeAccent,
  onSecondary: AppColors.secondaryColor,
  error: Colors.red,
  onError: AppColors.darkBlackColor,
  onSurface: AppColors.surfaceColor,
  surfaceTint: AppColors.darkBlackColor.withOpacity(0.2),
  onPrimaryContainer: AppColors.containerBgColor,
);

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.transparent,
    scrolledUnderElevation: 0.0,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.textColor),
    titleTextStyle: TextStyle(
      color: AppColors.textColor,
      fontSize: 16.sp,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
      fontFamily: FontFamily.roboto,
      // fontFamily: FontFamily.raleway,
    ),
  );
}
