import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/tab/seeding/addDetail/add_seeding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_colors.dart';
import 'common_widgets.dart';

class CustomAddDetailButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;

  const CustomAddDetailButton({
    super.key,
    required this.btnName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Your action here
        context.navigator.pushNamed(AddSeedingScreenPage.route);
      },
      icon:  SvgPicture.asset(Assets.icons.iconAddDetail.path), // use appropriate icon
      label: labelTextRegular(btnName, 10.sp, AppColors.white),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonBackgroundColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 12.sp),
      ),
    );
  }
}
