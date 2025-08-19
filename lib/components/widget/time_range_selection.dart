import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';

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
    final List<String> options = [S.of(context).day, S.of(context).week, S.of(context).month, S.of(context).year];

    return Row(
      children: options.map((label) {
        final bool isSelected = selected == label;

        return GestureDetector(
          onTap: () => onSelect(label),
          child: Container(
            margin: EdgeInsets.only(right: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.dateSelectionBg : AppColors.dateUnSelectionBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              label,
              style: AppTextStyles.robotoBodyRegular.copyWith(
                color: isSelected ? AppColors.white : AppColors.dateUnTextBg,
                fontSize: 10.sp
              )
            ),
          ),
        );
      }).toList(),
    );
  }
}
