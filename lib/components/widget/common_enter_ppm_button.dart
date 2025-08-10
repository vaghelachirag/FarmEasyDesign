
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../base/utils/app_colors.dart';



class CommonEnterPpmButton extends StatelessWidget {
  final String btnName;
  final String iconPath;
  final VoidCallback onPressed;


  const CommonEnterPpmButton({
    super.key,
    required this.btnName,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed:onPressed,
      icon:  SvgPicture.asset(iconPath, color: AppColors.infoTextHingBg,width: 20.sp,height: 20.sp,), // use appropriate icon
      label:  Text(btnName,style: TextStyle(fontSize: 11.sp,color: AppColors.infoTextHingBg),),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.addTotalPPFButtonBg,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 0.sp),
      ),
    );
  }
}
