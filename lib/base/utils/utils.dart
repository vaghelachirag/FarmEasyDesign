// lib/utils/utils.dart
import 'package:flutter/material.dart';

class Utils {
  /// Hides the keyboard if it is open
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Shows a snackBar with the given message
  static void showSnackBar(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? Colors.black,
      ),
    );
  }

  /// Validates if a string is a valid email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

/// Shows a toast (requires fluttertoast package)
/*
  static void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }
  */
}
