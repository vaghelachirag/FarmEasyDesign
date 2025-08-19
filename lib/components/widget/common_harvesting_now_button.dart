import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../base/utils/app_colors.dart';


class CustomerHarvestingNowButton extends StatelessWidget {
  final String btnName;
  final String iconPath;
  final VoidCallback onPressed;
  final Color backgroundColor ;
  final double buttonHeight ;
  final Color textColor;
  final Color iconColor ;

  const CustomerHarvestingNowButton({
    super.key,
    required this.btnName,
    required this.iconPath,
    required this.onPressed,
    required this.backgroundColor,
    required this.buttonHeight,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return
      ElevatedButton.icon(
      onPressed:onPressed,
      icon:  SvgPicture.asset(iconPath, color: iconColor,width: 20.sp,height: 20.sp,), // use appropriate icon
      label:  Text(btnName,style: AppTextStyles.robotoBodyLarge.copyWith(fontSize:  11.sp,color:textColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor:backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: buttonHeight),
      ),
    );
  }
}
