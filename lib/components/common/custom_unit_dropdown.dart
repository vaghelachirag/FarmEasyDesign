// widgets/common/custom_unit_dropdown.dart

import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/utils/app_colors.dart';
import '../../base/utils/constants.dart';
import '../../generator/assets.gen.dart';

class CustomUnitDropdown extends StatelessWidget {
  final String selectedUnit;
  final ValueChanged<String> onChanged;

  const CustomUnitDropdown({
    super.key,
    required this.selectedUnit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedUnit,
        isDense: true,
        dropdownColor: AppColors.addWeightTextFieldBg,
        icon: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: SvgPicture.asset(Assets.icons.iconDropdown.path),
        ),
        style: context.textTheme.labelMedium?.copyWith(color: Colors.white),
        items: weightUnits.map((unit) {
          return DropdownMenuItem<String>(
            value: unit,
            child: labelTextRegular(unit, 14.sp, AppColors.white),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        selectedItemBuilder: (BuildContext context) {
          return weightUnits.map((unit) {
            return Row(
              children: [
                Text(
                  unit,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            );
          }).toList();
        },
      ),
    );
  }
}
