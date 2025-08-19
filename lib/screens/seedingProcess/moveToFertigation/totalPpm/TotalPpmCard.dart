// ppm_card.dart
import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../base/utils/app_colors.dart';
import '../../../../base/utils/common_widgets.dart';
import '../../../../base/utils/dashline.dart';
import '../../../../components/widget/cycle_status_card.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import 'TotalPpmState.dart';

class TotalPpmCard extends ConsumerWidget {
  // Step 1: Create provider
  final isExpandedProvider = StateProvider<bool>((ref) => false);
  TotalPpmCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(isExpandedProvider);
    final ppmData = ref.watch(ppmProvider);
    return Container(
      width: 360.w,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
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
                              style: AppTextStyles.robotoBodyLarge.copyWith( fontSize: 12.sp,
                                color: AppColors.blackColor,)
                            ),
                            Text(
                              "Last Updated on ${DateFormat('dd/MM/yyyy').format(ppmData.lastUpdated)}",
                              style: AppTextStyles.robotoBodyRegular.copyWith(
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
                          style: AppTextStyles.robotoBodyLarge.copyWith(
                              fontSize: 30.sp,
                              color: AppColors.blackColor,
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
                        ref.read(isExpandedProvider.notifier).state = !isExpanded;
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          labelTextRegular(
                            isExpanded ? "Hide Details" : "View Details",
                            10.sp,
                            AppColors.blackColor,
                          ),
                          4.horizontalSpace,
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
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
          if (isExpanded) ...[
            DashedLine(
              height: 1,
              dashWidth: 6,
              dashSpacing: 4,
              color: Colors.grey.shade400,
            ),
            10.verticalSpace,
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                CycleStatusItem(title: 'Potassium Silicate', cycleCount: 120,header: S.of(context).ppm),
                CycleStatusItem(title: 'Micro 6-0-0', cycleCount: 160,header: S.of(context).ppm),
                CycleStatusItem(title: 'Bloom 0-6-5', cycleCount: 90,header: S.of(context).ppm),
              ],
            ),
            10.verticalSpace,
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                CycleStatusItem(title: 'CalMag', cycleCount: 120,header: S.of(context).ppm,),
                CycleStatusItem(title: 'SLF-100', cycleCount: 160,header: S.of(context).ppm),
                CycleStatusItem(title: 'ZeroTol 2.0', cycleCount: 90,header: S.of(context).ppm),
              ],
            ),
            10.verticalSpace
          ],
        ],
      ) ,
    );
  }
}

