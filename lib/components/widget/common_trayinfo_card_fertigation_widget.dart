import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/utils/app_colors.dart';
import '../../base/utils/app_decorations.dart';
import '../../generated/l10n.dart';
import '../common/app_text_styles.dart';

class CommonTrayInfoCardFertigationWidget extends StatelessWidget {
  final String seedingSummary;
  final List<String> seedLotCodes;
  final String trayDetails;
  final String coirWeight;
  final String currentStatus;
  final String statusDate;

  const CommonTrayInfoCardFertigationWidget({
    super.key,
    required this.seedingSummary,
    required this.seedLotCodes,
    required this.trayDetails,
    required this.coirWeight,
    required this.currentStatus,
    required this.statusDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(8.sp),
      margin: EdgeInsets.all(2.w),
      decoration: AppDecorations.seedingMainBg(
        AppColors.startSeedsMainBg,
        AppColors.startSeedsBorderBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            S.of(context).trayInformation,
            style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 14.sp),
          ),
          8.verticalSpace,
          // Seeding Summary
          Text(
            seedingSummary,
            style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 13.sp),
          ),
          8.verticalSpace,
          // Seed Lot Code
          Text(
            "Seed Lot Code:",
            style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 13.sp),
          ),
          6.verticalSpace,
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: seedLotCodes
                .map(
                  (code) => Container(
                padding:  EdgeInsets.symmetric(
                    horizontal: 5.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColors.seedLotBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  code,
                  style: AppTextStyles.robotoBodyRegular.copyWith(
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            )
                .toList(),
          ),
          8.verticalSpace,
          // Tray Details
          Text(
            "Tray Details:",
            style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 13.sp),
          ),
          Text(
            trayDetails,
            style: AppTextStyles.robotoBodyRegular.copyWith(
              fontSize: 12.sp,
              color: AppColors.labelTextColor,
            ),
          ),
          8.verticalSpace,
          // Coir Weight
          Text(
            "Coir Weight:",
            style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 12.sp),
          ),
          Text(
            coirWeight,
            style: AppTextStyles.robotoBodyRegular.copyWith(
              fontSize: 12.sp,
              color: AppColors.labelTextColor,
            ),
          ),
          8.verticalSpace,
          // Current Status + Date Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Status:",
                      style: AppTextStyles.robotoBodyRegular.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currentStatus,
                      style: AppTextStyles.robotoBodyRegular.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDateBadge(statusDate),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.trayInfoPopupBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTextStyles.robotoBodyRegular.copyWith(
          fontSize: 10.sp,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
