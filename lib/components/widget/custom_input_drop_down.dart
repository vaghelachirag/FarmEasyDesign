import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownField extends StatelessWidget {
  final String title;
  final String hintText;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final Widget? suffix;
  final FormFieldValidator<String>? validator;

  const CustomDropdownField({
    super.key,
    required this.title,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: selectedValue,
          items: items
              .map((item) => DropdownMenuItem(
            value: item,
            child: Text(item,style: context.textTheme.labelMedium?.copyWith(fontSize: 12.sp,color: AppColors.infoTextHingBg),),
          ))
              .toList(),
          onChanged: onChanged,
          validator: validator,
          decoration:
          AppDecorations.mainInputTextDecoration(hintText, title, suffix),
        ),
      ],
    );
  }
}
