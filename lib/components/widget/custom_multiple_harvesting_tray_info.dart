import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/utils/common_widgets.dart';

class CustomMultipleHarvestingTrayInfo extends StatelessWidget {
  const CustomMultipleHarvestingTrayInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.r),
      padding: EdgeInsets.all(16.r),
      decoration: AppDecorations.multipleHarvestingInfoDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text("Products",
              style: context.textTheme.labelMedium?.copyWith(color: Colors.black,fontSize: 14.sp)),
         8.verticalSpace,
          // Crop Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Crop Details\n",
                      style: context.textTheme.labelLarge?.copyWith(color: Colors.black,fontSize: 12.sp),
                    ),
                    TextSpan(
                      text: "Arugula 50 gms",
                      style: context.textTheme.labelLarge?.copyWith(color: Colors.black,fontSize: 12.sp)),
                  ],
                ),
              ),
              Container(
                padding:
                EdgeInsets.all(8.w),
                decoration: AppDecorations.infoWindowBg(),
                child: Text(
                  "Seeded on 25/05/2025",
                  style: context.textTheme.titleSmall?.copyWith(fontSize: 12.sp,color: AppColors.infoTextHingBg),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Total Trays",
                  style: context.textTheme.titleSmall?.copyWith(color: AppColors.disableIconColor,fontSize: 12.sp)),
              8.horizontalSpace,
              Text("16F/18F | 8H/10H",
                  style: context.textTheme.titleSmall?.copyWith(color: AppColors.blackColor,fontSize: 12.sp))
            ],
          ),
          SizedBox(height: 8.h),
          // Progress bar
          customProgressBar(AppColors.white,AppColors.infoQrScanWindowBg,0.75),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("74%",
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xFF4A4459))),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '40 gms',
                      style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.blackColor),
                    ),
                    TextSpan(
                      text: ' Total Yield',
                      style:  context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.disableIconColor),
                    ),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 16.h),
          commonInfoWidgetWithText(context,"Harvest Due Today.","Complete Harvest before •22:00 Today")
/*
          // Harvest box
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFFF2E58C),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: Color(0xFF4A4459)),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Harvest Due Today.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: const Color(0xFF4A4459))),
                      Text("Complete Harvest before • 22:00 Today",
                          style: TextStyle(
                              fontSize: 12.sp, color: const Color(0xFF4A4459))),
                    ],
                  ),
                )
              ],
            ),
          ) */
        ],
      ),
    );
  }
}
