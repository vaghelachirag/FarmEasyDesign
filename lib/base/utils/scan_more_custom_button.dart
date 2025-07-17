import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanMoreCustomButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;

  const ScanMoreCustomButton({
    super.key,
    required this.btnName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed ,
      icon: SvgPicture.asset(Assets.icons.iconScanMore.path),
      label:
      labelTextRegular(btnName,10.sp, AppColors.buttonBackgroundColor),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.infoTextHingBg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 12.sp),
      ),
    );
  }
}
