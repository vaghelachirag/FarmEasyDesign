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
                _buildCircleIcon(step.path),
                if (!isLast)
                  Container(
                    height: 50.w,
                    width: 2,
                    color: const Color(0xFFCAC4D0),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            // Row content: Status Chip and Text (in horizontal layout)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusChip(step.label),
                  const SizedBox(width: 8),
                  Text(
                    step.statusDate,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12,
                      color: step.isCompleted
                          ? const Color(0xFF4A4459)
                          : const Color(0xFF3A7F0D),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildCircleIcon(String path) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF23C072),
          width: 2,
        ),
      ),
      child:
      CircleAvatar(
        radius: 14,
        backgroundColor: Colors.white,
        child:  SvgPicture.asset(path),
      ),
    );
  }

  Widget _buildStatusChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4EC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF4A4459),
        ),
      ),
    );
  }
}
