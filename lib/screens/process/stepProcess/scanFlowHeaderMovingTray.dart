import 'package:farmeasy/screens/process/stepProcess/processStepperMovingTray.dart';
import 'package:farmeasy/screens/process/stepProcess/stepConfigMovingTray.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../base/utils/app_colors.dart';
import '../../../base/utils/common_widgets.dart';

class ScanFlowHeaderMovingTray extends ConsumerWidget {
  const ScanFlowHeaderMovingTray({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = const [
      StepConfigMovingTray(caption: 'Step 1', label: 'Scan Tray QR',   icon: Icons.qr_code_scanner),
      StepConfigMovingTray(caption: 'Step 2', label: 'Confirm Details', icon: Icons.edit_rounded),
      StepConfigMovingTray(caption: 'Step 3', label: 'Scan Level QR',  icon: Icons.qr_code_2_rounded),
    ];

    // Initialize step controller if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(stepControllerProvider(steps.length).notifier);
      // Reset to initial state when widget is built
      controller.reset();
    });

    return Container(
      decoration: boxDecoration(AppColors.white, AppColors.basePrimaryColor),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: ProcessStepperMovingTray(steps: steps),
    );
  }
}
