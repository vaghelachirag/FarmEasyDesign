// file: app_decorations.dart
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDecorations {
  static BoxDecoration seedingMainBg() {
    return  BoxDecoration(
      color: AppColors.startSeedsMainBg,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color:  AppColors.startSeedsBorderBg, // very light green border
        width: 1,
      ),
    );
  }

  // You can add more common decorations here
  static BoxDecoration seedingBg() {
    return  BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: AppColors.startSeedsBorderBg, // very light green border
        width: 1,
      ),
    );
  }
}
