import 'package:farmeasy/screens/process/stepProcess/processStepperMovingTray.dart';
import 'package:farmeasy/screens/process/stepProcess/stepConfigMovingTray.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../base/utils/app_colors.dart';

class ScanFlowHeaderMovingTray extends ConsumerWidget {
  const ScanFlowHeaderMovingTray({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = const [
      StepConfigMovingTray(
        caption: 'Step 1', 
        label: 'Scan Level QR',   
        icon: Icons.qr_code_scanner
      ),
      StepConfigMovingTray(
        caption: 'Step 2', 
        label: 'Add Details', 
        icon: Icons.edit_rounded
      ),
      StepConfigMovingTray(
        caption: 'Step 3', 
        label: 'Scan Level QR',  
        icon: Icons.qr_code_2_rounded
      ),
    ];

    // Initialize step controller if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(stepControllerProvider(steps.length).notifier);
      // Reset to initial state when widget is built
      controller.reset();
    });

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: ProcessStepperMovingTray(steps: steps),
    );
  }
}
