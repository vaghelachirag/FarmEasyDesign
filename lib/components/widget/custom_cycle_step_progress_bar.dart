import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/model/model_cycle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/tab/cycles/cycles_page.dart';


class CustomCycleStepProgressBar extends StatelessWidget {

  final ModelCycle cycle;

  const CustomCycleStepProgressBar({super.key, required this.cycle});

  @override
  Widget build(BuildContext context) {

    //final double progress; // 0.0 to 1.0
    final progress = calculateProgress(cycle);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // smooth rounded edges
      child: Container(
        height: 3.w, // as per image height
        decoration: BoxDecoration(
          color: AppColors.unProgressBg, // light background
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: progress, // progress from 0 to 1
            child: Container(
              decoration:  BoxDecoration(
                color: AppColors.selectedProgressBg, // dark green
              ),
            ),
          ),
        ),
      ),
    );
  }
}
