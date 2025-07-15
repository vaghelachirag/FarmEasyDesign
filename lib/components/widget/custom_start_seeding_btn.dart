import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';

class StartSeedingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String? iconPath;

   StartSeedingButton({
    super.key,
    required this.onPressed,
    this.label = 'Start Seeding',
    this.iconPath
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        Assets.icons.iconStartSeed.path,
        width: 16.sp,
        height: 16.sp,
        fit: BoxFit.contain,
      ),
      label: Text(
        label,
        style: context.textTheme.labelLarge?.copyWith(
          color: AppColors.white,
          fontSize: 12.sp,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF388E3C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
      ),
    );
  }
}
