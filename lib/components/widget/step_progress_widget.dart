import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/tab/seeding/provider/seeding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepProgressWidget extends HookConsumerWidget {
  const StepProgressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(currentStepProvider);

    final steps = [
      _StepData('Scan seed Lot', Assets.icons.iconScan.path),
      _StepData('Add Details', Assets.icons.iconEdit.path),
      _StepData('Scan Level QR', Assets.icons.iconScan.path),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [  cercle(context),  cercle(context),  cercle(context)],
      )

    );
  }

  Widget cercle(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Container(
    padding: EdgeInsets.all(10.r),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: AppColors.primary, width: 1.5),
    ),
    child: SvgPicture.asset(
    Assets.icons.iconScan.path,
    height: 20.r,
    width: 20.r,
    colorFilter: ColorFilter.mode(AppColors.black16, BlendMode.srcIn),
    ),
    ),
        SizedBox(height: 8.h),
        Text(
          'Step 1',
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: 10.sp,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          'Scan seed Lot',
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.start, // This is optional now
        ),
      ],
    );
  }
  Widget _buildStepCircle(String path, bool isActive, bool isCompleted) {
    final borderColor = isCompleted || isActive ? Colors.green : Colors.green;

    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: SvgPicture.asset(
        path,
        height: 20.r,
        width: 20.r,
        colorFilter: ColorFilter.mode(borderColor, BlendMode.srcIn),
      ),
    );
  }
}

class _StepData {
  final String label;
  final String icon;

  _StepData(this.label, this.icon);
}
