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

  static BoxDecoration scanQrcodeBg(){
    return  BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
         AppColors.primary,                // Green
          Color.fromRGBO(0, 0, 0, 0.1),     // Light black
        ],
      ),
    );
  }

  static BoxDecoration infoWindowBg(){
    return BoxDecoration(
      color: AppColors.infoQrScanWindowBg,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: AppColors.infoQrScanWindowBorderBg),
    );
  }

}

