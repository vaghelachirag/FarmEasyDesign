import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      },
      icon: Icon(Icons.edit, color: Colors.white), // use appropriate icon
      label: labelTextRegular(btnName, 10.sp, AppColors.white),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonBackgroundColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
