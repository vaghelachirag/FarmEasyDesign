import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TopHeaderHomePage extends StatelessWidget {
  final String title;
  final String date;
  final String assetPath;

  const TopHeaderHomePage({
    super.key,
    required this.title,
    required this.date,
    required this.assetPath
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Row(
      children: [
        SvgPicture.asset(
          assetPath,
          width: width * 0.08,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.labelLarge?.copyWith(fontSize: 12.sp,color: AppColors.blackColor),
            ),
            Text(
              'Last Updated on $date',
              style: context.textTheme.labelLarge?.copyWith(fontSize: 8.sp,color: AppColors.infoTextHingBg),
            )
          ],
        )
      ],
    );
  }
}
