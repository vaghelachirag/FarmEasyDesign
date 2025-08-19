import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/app_text_styles.dart';

class CommonNextActionButton extends StatelessWidget {
  final String description;
  final String days;
  final String hours;
  final String minutes;
  final String moveDate;

  const CommonNextActionButton({
    super.key,
    required this.description,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.moveDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.sp),
      decoration: AppDecorations.infoWindowBg(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with icon and description
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.black87, size: 18),
              5.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                     style:AppTextStyles.robotoBodyRegular.copyWith(fontSize: 12.sp,color: AppColors.infoTextHingBg)),
                    5.verticalSpace,
                    Row(
                      children: [
                        Text("Time Left ",  style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 12.sp,color: AppColors.blackColor)),
                        5.horizontalSpace,
                        _timeBox(days, "d",context),
                         3.horizontalSpace,
                        _timeBox(hours, "h",context),
                        3.horizontalSpace,
                        _timeBox(minutes, "m",context),
                      ],
                    ),
                    5.verticalSpace,
                    Text("Move to Fertigation: $moveDate",style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 12.sp,color: AppColors.blackColor)),
                    10.verticalSpace
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _timeBox(String value, String unit, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.timeLeftBoxBg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "$value$unit",
        style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 12.sp,color: AppColors.blackColor),
      ),
    );
  }
}
