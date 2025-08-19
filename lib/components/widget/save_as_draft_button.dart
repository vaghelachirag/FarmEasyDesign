import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../gen/assets.gen.dart';
import '../../generated/l10n.dart';

class SaveAsDraftButton extends StatelessWidget {
  const SaveAsDraftButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.saveAsDraftButtonBg, // light green background
        foregroundColor: AppColors.blackColor, // text & icon color
        elevation: 0, // flat look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // rounded corners
        ), side:  BorderSide(
            color: AppColors.buttonBackgroundColor, // border color (green)
            width: 1, // border thickness
          ),
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      ),
      onPressed: () {
        // Handle save draft action
      },
      icon: SvgPicture.asset(Assets.icons.iconDraft), // three dots icon
      label:  Text(
        S.of(context).saveAsDraft,
        style: context.textTheme.labelLarge?.copyWith(fontSize: 11.sp,color: AppColors.infoTextHingBg),
      ),
    );
  }
}
