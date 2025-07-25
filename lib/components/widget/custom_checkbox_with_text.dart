import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../base/utils/common_widgets.dart';


class CustomCheckboxWithText extends ConsumerWidget {

  final bool isChecked ;
  final String title ;

   const CustomCheckboxWithText({super.key, required this.title,required this.isChecked});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        customCheckbox(isChecked),
        8.horizontalSpace,
        Text(title,style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.checkboxBorderActiveBg),)
      ],
    );
  }

}
