import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProceedButton extends StatelessWidget {
  final String title ;
  final String iconPath;
  final VoidCallback onPressed;

  const CustomProceedButton({super.key, required this.onPressed, required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width:  0.9.sw,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          iconPath, // Replace with your actual SVG asset path
          height: 20.sp,
          width: 20.sp,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        label: labelTextRegular( title, 16.sp, AppColors.white),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF237A4C), // Green color from image
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          elevation: 0,
        ),
      ),
    );
  }
}
