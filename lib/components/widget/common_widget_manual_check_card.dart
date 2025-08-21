import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';

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
                    style: AppTextStyles.robotoBodyLarge.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    S.of(context).thisDataWillBeRecordedAndUsedByTheSystem,
                    style: AppTextStyles.robotoBodyRegular.copyWith(
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
               Assets.images.deleteTrayBg.path,
              ),
              SvgPicture.asset(
                Assets.images.deleteTray.path,
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
