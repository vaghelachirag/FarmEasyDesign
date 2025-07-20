import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/tab/cycles/cycles_page.dart';

final seedingStatusProvider = StateProvider<SeedingStatus>((ref) {
  return SeedingStatus.idle;
});

enum SeedingStatus { idle, started, issueMarked }

class CustomSeedingActionSection extends StatelessWidget {
  final String buttonText;

  CustomSeedingActionSection({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        10.verticalSpace,
        labelTextRegular('Complete Seeding before • 22:00 Today', 12.sp, AppColors.totalAssignPersonTextBg),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 150.w, // half screen with padding
              height: 30.w,
              child: ElevatedButton.icon(
                style: AppDecorations.startSeedingButtonStyle(),
                onPressed: () {},
                icon: SvgPicture.asset(
                  Assets.icons.iconStartSeed.path,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                label: labelTextRegular( buttonText, 12.sp, AppColors.white),
              ),
            ),
            20.horizontalSpace,
            Expanded(child:
            SizedBox(
              width: 120.w,
              height: 30.w,
              child: AppDecorations.markAsReadButtonStyle(),
            )),
          ],
        )
      ],
    )
    ;
  }
}