import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../base/utils/common_widgets.dart';

class TimelineStep {
  final String path;
  final String label;
  final String statusDate;
  final bool isCompleted;

  TimelineStep({
    required this.path,
    required this.label,
    required this.statusDate,
    required this.isCompleted,
  });
}

class CustomNutrietionTimeLineWidget extends StatelessWidget {
  CustomNutrietionTimeLineWidget({super.key});

  final List<TimelineStep> steps = [
    TimelineStep(
      path: Assets.icons.iconNutriationDrop.path,
      label: "Seeding",
      statusDate: "Completed on\n22/05/2025 | 11:00 AM",
      isCompleted: true,
    ),
    TimelineStep(
      path: Assets.icons.iconNutriationLeaf.path,
      label: "Moved to Germination",
      statusDate: "Completed on\n22/05/2025 | 11:00 AM",
      isCompleted: true,
    ),
    TimelineStep(
      path: Assets.icons.iconNutriationPlant.path,
      label: "Germination",
      statusDate: "Completed on\n22/05/2025 | 11:00 AM",
      isCompleted: true,
    ),
    TimelineStep(
      path: Assets.icons.iconNutriationUpcoming.path,
      label: "Upcoming",
      statusDate: "Due on\n22/05/2025 | 11:00 AM",
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline Icon & Line
            Column(
              children: [
                buildCircleIcon(step.path,context),
                if (!isLast)
                  Container(
                    margin: EdgeInsets.only(top: 8.sp,bottom: 8.sp),
                    height: 50.w,
                    width: 4,
                    color: AppColors.white,
                  ),
              ],
            ),
            4.horizontalSpace,
            // Row content: Status Chip and Text (in horizontal layout)
            Expanded(
              child: Row(
               mainAxisSize: MainAxisSize.min,
                children: [
                  buildStatusChip(step.label, context),
                  4.horizontalSpace,
                  buildCompletedDate(step.statusDate,context)
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  Widget buildTimelineStep({
    required IconData icon,
    required String label,
    required String dateText,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // Timeline Circle with icon
            circularSeedingProcessTimeLine(isCompleted,icon),
            // Vertical line
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: AppColors.white,
              ),
          ],
        ),
        12.horizontalSpace
      ],
    );
  }
}
