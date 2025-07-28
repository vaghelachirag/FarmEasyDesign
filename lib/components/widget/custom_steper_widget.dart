import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../base/utils/app_colors.dart';
import '../../generator/assets.gen.dart';

import '../../model/model_cycle.dart';
import '../../screens/tab/cycles/provider/cycles_provider.dart';

class StepperWidget extends ConsumerWidget {
  final ModelCycle cycle;
  const StepperWidget({super.key, required this.cycle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStage = cycle.currentStage; // Enum: CycleStage
    final currentStageIndex = CycleStage.values.indexOf(currentStage);

    final Map<CycleStage, String> stageIcons = {
      CycleStage.seeding: Assets.icons.iconSeeds.path,
      CycleStage.germination: Assets.icons.iconSeeds.path,
      CycleStage.moveToFertigation: Assets.icons.iconDrop.path,
      CycleStage.harvesting: Assets.icons.iconHummer.path,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(stageIcons.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Divider line
          return Expanded(
            child: Divider(
              color: AppColors.cycleDividerBg,
              thickness: 4.sp,
            ),
          );
        } else {
          int stageIndex = index ~/ 2;
          final stage = CycleStage.values[stageIndex];
          return  stageIndex < currentStageIndex ?  stepImage(Assets.images.iconSeedingDone.path,stageIndex,currentStageIndex) : stepImage(stageIcons[stage]!,stageIndex,currentStageIndex);
        }
      }),
    );
  }
}
Widget stepImage(String path, int stageIndex, int currentStageIndex){
  return Container(
      width: 40.w,
      height: 40.w,
      padding: stageIndex < currentStageIndex ? EdgeInsets.all(0) : EdgeInsets.all(10),
  decoration: BoxDecoration(
  shape: BoxShape.circle,
  color: AppColors.cycleRoundBackgroundBg,
  border: Border.all(
  color: AppColors.cycleRoundBorderBg,
  width: 1.sp,
  ),
  ),
  child:
  SvgPicture.asset(path));
}
