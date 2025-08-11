// ppm_card.dart
import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../base/utils/app_colors.dart';
import '../../../../base/utils/common_widgets.dart';
import '../../../../gen/assets.gen.dart';
import 'TotalPpmState.dart';

class TotalPpmCard extends ConsumerWidget {
  const TotalPpmCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ppmData = ref.watch(ppmProvider);

    return Container(
      width: 340,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Left Side
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.icons.iconTotalPpmTree),
                    10.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total PPM",
                          style: context.textTheme.titleLarge?.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.blackColor,
                          ),
                        ),
                        Text(
                          "Last Updated on ${DateFormat('dd/MM/yyyy').format(ppmData.lastUpdated)}",
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 8.sp,
                            color: AppColors.customCycleTabUnSelectedTextColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                3.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    10.horizontalSpace,
                    Text(
                      ppmData.ppmValue.toString(),
                      style: context.textTheme.labelLarge?.copyWith(
                          fontSize: 32.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    15.horizontalSpace,
                    SvgPicture.asset(Assets.icons.iconEditCircle)
                  ],
                ),
              ],
            ),
          ),

          // Right Side (Gauge)
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              30.verticalSpace,
              SvgPicture.asset(Assets.images.imageTotalPpm,width: 100.w,),
              10.verticalSpace,
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      labelTextRegular(
                        "View Details",
                        10.sp,
                        AppColors.blackColor,
                      ),
                      4.horizontalSpace,
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black54,
                        size: 18.sp,
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpace
            ],
          ),
        ],
      ),
    );
  }
}

