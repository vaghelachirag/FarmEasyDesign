import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeRangeSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;

  const TimeRangeSelector({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['Day', 'Week', 'Month', 'Year'];

    return Row(
      children: options.map((label) {
        final bool isSelected = selected == label;

        return GestureDetector(
          onTap: () => onSelect(label),
          child: Container(
            margin: EdgeInsets.only(right: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.dateSelectionBg : AppColors.dateUnSelectionBg,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              label,
              style: context.theme.textTheme.labelSmall?.copyWith(
                color: isSelected ? AppColors.white : AppColors.dateUnTextBg
              )
            ),
          ),
        );
      }).toList(),
    );
  }
}
