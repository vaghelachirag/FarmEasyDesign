import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';


class CustomCycleStepProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const CustomCycleStepProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // smooth rounded edges
      child: Container(
        height: 6, // as per image height
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
