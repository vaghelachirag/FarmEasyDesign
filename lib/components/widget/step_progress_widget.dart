import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../base/utils/app_colors.dart';
import '../../base/utils/common_widgets.dart';
import '../../generator/assets.gen.dart';
import '../../screens/tab/cycles/provider/cycles_provider.dart';

class StepProgressIndicator extends StatelessWidget {
  final CycleStage currentStepName;

  const StepProgressIndicator({
    super.key,
    required this.currentStepName,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      ('Step 1', 'Scan seed Lot', Assets.icons.iconQr.path),
      ('Step 2', 'Add Details', Assets.icons.iconEdit.path),
      ('Step 3', 'Scan Level QR', Assets.icons.iconSeedingQr.path),
    ];

    final currentStep = _getStepIndexFromCycleStage(currentStepName);

    return Container(
      decoration: boxDecoration(AppColors.white, AppColors.basePrimaryColor),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
           loadTopProcessWidget(currentStep),
         // _mainWidget(steps, context, currentStep),
        ],
      ),
    );
  }

  Widget loadTopProcessWidget(int currentStep){
    return switch (currentStep) {
      0 =>  loadGerminationWidget(),
      1 =>  loadGerminationWidget(),
      2 => loadGerminationWidget(),
      _ => Text("Unknown"),
    };
  }

  /// 🧠 Map each [CycleStage] to an index (0-based)
  int _getStepIndexFromCycleStage(CycleStage stage) {
    switch (stage) {
      case CycleStage.seeding:
        return 0;
      case CycleStage.movement:
        return 1;
      case CycleStage.germination:
        return 2;
      case CycleStage.fertigation:
      case CycleStage.harvesting:
      default:
        return 2; // Final step for unsupported stages
    }
  }

  Widget _mainWidget(
      List<(String, String, String)> steps, BuildContext context, int currentStep) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 22.h),
              height: 1.5.h,
              color: AppColors.primary,
            ),
          );
        } else {
          final stepIndex = index ~/ 2;
          final isActive = stepIndex == currentStep;
          final isCompleted = stepIndex < currentStep;

          return _buildStepCircle(
            context,
            stepTitle: steps[stepIndex].$1,
            stepLabel: steps[stepIndex].$2,
            iconPath: steps[stepIndex].$3,
            isActive: isActive,
            isCompleted: isCompleted,
          );
        }
      }),
    );
  }

  Widget _buildStepCircle(
      BuildContext context, {
        required String stepTitle,
        required String stepLabel,
        required String iconPath,
        required bool isActive,
        required bool isCompleted,
      }) {
    final circleColor =
    isCompleted || isActive ? AppColors.customCycleTabUnSelectedColor : AppColors.customCycleTabUnSelectedColor;
    final iconColor = isActive ? AppColors.customCycleTabSelectedColor : AppColors.customCycleTabSelectedColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 1.5),
            color: circleColor,
          ),
          child: SvgPicture.asset(
            iconPath,
            height: 20.r,
            width: 20.r,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          stepTitle,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 10.sp,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          stepLabel,
          style: context.textTheme.labelLarge?.copyWith(fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

 Widget loadGerminationWidget() {
    return Container(
        padding: EdgeInsets.only(bottom: 30.sp),
        child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 1.5),
            color: AppColors.primary,
          ),
          child: SvgPicture.asset(
            Assets.icons.iconSeedingQr.path,
            height: 20.r,
            width: 20.r,
            colorFilter: ColorFilter.mode(AppColors.cycleStepProcessBg, BlendMode.srcIn),
          ),
        ),
        20.horizontalSpace,
        labelTextRegular("Scan Level QR", 14.sp, AppColors.blackColor),
      ],
    ));
 }
}
