import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../screens/tab/cycles/provider/cycles_provider.dart';

class StepperWidget extends ConsumerWidget {
  const StepperWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedStepProvider);

    final List<String> icons = [
      Assets.icons.iconSeeds.path,
      Assets.icons.iconPlant.path,
      Assets.icons.iconDrop.path,
      Assets.icons.iconHummer.path,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(icons.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Line between circles
          return
            Expanded(
            child: Divider(
              color:  AppColors.cycleDividerBg,
              thickness: 4.sp,
            ),
          );
        } else {
          int iconIndex = index ~/ 2;
          bool isSelected = iconIndex == selectedIndex;

          return GestureDetector(
            onTap: () {
              ref.read(selectedStepProvider.notifier).state = iconIndex;
            },
            child:
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cycleRoundBackgroundBg,
                border: Border.all(
                  color: AppColors.cycleRoundBorderBg,
                  width: 1.sp,
                ),
              ),
              child:
              SvgPicture.asset(icons[iconIndex])
            ),
          );
        }
      }),
    );
  }
}
