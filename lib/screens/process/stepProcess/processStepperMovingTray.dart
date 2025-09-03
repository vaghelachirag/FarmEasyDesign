import 'dart:ui';

import 'package:farmeasy/screens/process/stepProcess/stepConfigMovingTray.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../base/utils/app_colors.dart';

class ProcessStepperMovingTray extends ConsumerWidget {
  final List<StepConfigMovingTray> steps;
  final Color primary;
  final Color success;
  final Color errorColor;
  final Color neutral;

  const ProcessStepperMovingTray({
    super.key,
    required this.steps,
    this.primary = const Color(0xFF20C997),
    this.success = const Color(0xFF20C997),
    this.errorColor = const Color(0xFFE53935),
    this.neutral = const Color(0xFFCFD8DC),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stepControllerProvider(steps.length));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          // connector line
          final leftIndex = (i ~/ 2);
          final leftDone = state.statuses[leftIndex] == StepStatus.completed;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              height: 2.h,
              decoration: BoxDecoration(
                color: leftDone ? primary : neutral.withOpacity(0.5),
                borderRadius: BorderRadius.circular(1.r),
              ),
            ),
          );
        } else {
          final index = i ~/ 2;
          final status = state.statuses[index];
          final cfg = steps[index];
          return _StepItem(
            caption: cfg.caption,
            label: cfg.label,
            icon: cfg.icon,
            status: status,
            primary: primary,
            success: success,
            errorColor: errorColor,
            neutral: neutral,
          );
        }
      }),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String caption;
  final String label;
  final IconData icon;
  final StepStatus status;
  final Color primary, success, errorColor, neutral;

  const _StepItem({
    required this.caption,
    required this.label,
    required this.icon,
    required this.status,
    required this.primary,
    required this.success,
    required this.errorColor,
    required this.neutral,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == StepStatus.completed;
    final isCurrent = status == StepStatus.current;
    final isError = status == StepStatus.error;

    final circleSize = 40.0;
    final borderColor = isCompleted || isCurrent ? success : neutral;
    final fillColor = isCompleted
        ? success
        : isCurrent
        ? success
        : Colors.transparent;
    final iconColor = isCompleted ? Colors.white : borderColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 6),
        // circle with icon
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            color: fillColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Icon(
              isCompleted ? Icons.check_rounded : icon,
              size: 20.sp,
              color: iconColor,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          caption,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.hintTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textColor,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
