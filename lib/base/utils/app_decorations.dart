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

  static BoxDecoration  addWeightDecoration(){
    return  BoxDecoration(
      color: AppColors.addWeightTextFieldBg,
      borderRadius: BorderRadius.circular(4),
    );
  }

  static InputDecoration mainInputTextDecoration(String hintText, String title, Widget? suffix){
    return InputDecoration(
      hintText: hintText,
      floatingLabelBehavior:FloatingLabelBehavior.always,
      labelText: title,
      alignLabelWithHint: true,
      labelStyle:  TextStyle(
        color: AppColors.inputLabelColor,
      ),
      enabledBorder: outlineInputBorder(5.r, AppColors.borderColor,1),
      focusedBorder: outlineInputBorder(5.r, AppColors.borderColor,1),
      errorBorder: outlineInputBorder(5.r, AppColors.borderColor,1),
      focusedErrorBorder: outlineInputBorder(5.r, AppColors.borderColor,1),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 14),
      suffixIcon: suffix,
    );
  }
}

OutlineInputBorder outlineInputBorder(double r, Color borderColor, double intWidth){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(r),
    borderSide:  BorderSide(color: borderColor, width: intWidth),
  );
}

