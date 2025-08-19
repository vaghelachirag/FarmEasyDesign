import 'package:flutter/material.dart';

class AppTextStyles {
  // Poppins Titles
  static const TextStyle poppinsTitleLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
  );

  static const TextStyle poppinsTitleMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w600, // SemiBold
  );

  // Roboto Body
  static const TextStyle robotoBodyLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium
  );

  static const TextStyle robotoBodyRegular = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
  );

  // Example italic
  static const TextStyle robotoBodyItalic = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );
}
