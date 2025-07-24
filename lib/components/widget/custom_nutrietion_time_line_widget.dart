import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                _buildCircleIcon(step.path,context),
                if (!isLast)
                  Container(
                    height: 50.w,
                    width: 2,
                    color: const Color(0xFFCAC4D0),
                  ),
              ],
            ),
            4.horizontalSpace,
            // Row content: Status Chip and Text (in horizontal layout)
            Expanded(
              child: Row(
               mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStatusChip(step.label, context),
                  4.horizontalSpace,
                  Flexible(
                    child:
                    Text(step.statusDate,style: context.textTheme.labelMedium?.copyWith(fontSize: 11.sp,color: AppColors.infoTextHingBg),)
                  ),
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
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? Color(0xFF23C072) : Color(0xFFCAC4D0),
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: 16,
                color: isCompleted ? Color(0xFF23C072) : Color(0xFFCAC4D0),
              ),
            ),
            // Vertical line
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Color(0xFFCAC4D0),
              ),
          ],
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildCircleIcon(String path, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF23C072),
          width: 1,
        ),
      ),
      child:
      Container(
          padding: EdgeInsets.all(2.sp),
          child:CircleAvatar(
        radius: 14,
        backgroundColor: Colors.white,
        child:  SvgPicture.asset(path),
      ),
      )
    );
  }

  Widget _buildStatusChip(String label, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
      decoration: AppDecorations.nutriationChipDecoration(),
      child: 
      Row(
        children: [
          SvgPicture.asset(Assets.icons.iconSeeds.path,width: 20.w,height: 20.w),
          5.horizontalSpace,
          Text(label,style: context.textTheme.labelMedium?.copyWith(
            fontSize: 12.sp,color: AppColors.infoTextHingBg
          ))
        ],
      )
    );
  }
}
