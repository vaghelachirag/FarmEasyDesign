import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHarvestReminderCard extends StatelessWidget {
  const CustomHarvestReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.trayInfoPopupBg, // Background color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            Assets.icons.iconInfoBlub.path,
            height: 24.w,
            width: 24.w,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text( 'Harvest Due Today.',style: context.textTheme.labelMedium?.copyWith(fontSize: 12.sp,color: AppColors.infoTextHingBg)),
                SizedBox(height: 4),
                Text( 'Complete Harvest before • 22:00 Today',style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.infoTextHingBg)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
