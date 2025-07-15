import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final isActive = index == currentStep;
          final isCompleted = index < currentStep;

          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    if (index > 0)
                      Expanded(
                        child: Container(
                          height: 1.5.h,
                          color: isCompleted ? Colors.green : Colors.grey.shade300,
                        ),
                      ),
                    _buildStepCircle(steps[index].icon, isActive, isCompleted),
                    if (index < steps.length - 1)
                      Expanded(
                        child: Container(
                          height: 1.5.h,
                          color: (index < currentStep) ? Colors.green : Colors.grey.shade300,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Step ${index + 1}',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 10.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  steps[index].label,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepCircle(String path, bool isActive, bool isCompleted) {
    final borderColor = isCompleted || isActive ? Colors.green : Colors.grey;

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
