import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonWidgetManualCheckCard extends StatelessWidget {
  final String title;
  const CommonWidgetManualCheckCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.seedingBg().copyWith(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Left Text Section with padding
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  10.verticalSpace,
                  Text(
                    title,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    'This Data will be recorded and used by the system to have a better yield in future.',
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 10.sp,
                      color: AppColors.infoTextHingBg,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Image Section (flush with edge)
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/delete_traybg.svg',
              ),
              SvgPicture.asset(
                'assets/images/delete_tray.svg',
                width: 120.w,
                height: 120.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
