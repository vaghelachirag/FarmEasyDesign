import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonWidgetManualCheckCard extends StatelessWidget {
  final String title;
  const CommonWidgetManualCheckCard({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 364.w,
      height: 155.h,
      padding: EdgeInsets.all(16.w),
      decoration:  AppDecorations.seedingBg(),
      child: Row(
        children: [
          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text( title, style: context.textTheme.labelMedium?.copyWith(fontSize: 14.sp,color: AppColors.blackColor)),
                10.verticalSpace,
                Text(  "This Data will be recorded and used by\nthe system to have a better yield in\nfuture.", style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.blackColor)),
              ],
            ),
          ),
          // Image/Icon Section
          SizedBox(width: 12.w),
          SizedBox(
            width: 80.w,
            height: 80.w,
            child:
            SvgPicture.asset(Assets.images.iconSeedingDone.path,color: AppColors.primary,)
          ),
        ],
      ),
    );
  }
}
