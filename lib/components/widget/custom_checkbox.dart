import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base/utils/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final checkboxTheme = Theme.of(context).checkboxTheme;

    return Checkbox(
      value: value,
      activeColor: AppColors.primary,
      checkColor: checkboxTheme.checkColor?.resolve({}) ?? Colors.grey,
      shape: checkboxTheme.shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
      side: checkboxTheme.side ?? const BorderSide(color: AppColors.checkboxColor),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      onChanged: onChanged,
    );
  }
}
