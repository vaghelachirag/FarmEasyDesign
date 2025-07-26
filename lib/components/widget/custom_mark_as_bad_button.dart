import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/seedingProcess/seedingTrays/addPersonDetail/add_person_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../base/utils/app_colors.dart';
import '../../base/utils/common_widgets.dart';


class CustomMarkAsBadButton extends StatelessWidget {
  final String btnName;
  final String iconPath;
  final VoidCallback onPressed;


  const CustomMarkAsBadButton({
    super.key,
    required this.btnName,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed:onPressed,
      icon:  SvgPicture.asset(iconPath, color: AppColors.white), // use appropriate icon
      label: labelTextRegular(btnName, 12.sp, AppColors.white),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.errorBorderColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 12.sp),
      ),
    );
  }
}
