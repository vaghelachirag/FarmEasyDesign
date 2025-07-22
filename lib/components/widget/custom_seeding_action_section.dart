import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/seedingProcess/harvestingTrays/harvesting_trays_screens.dart';
import 'package:farmeasy/screens/seedingProcess/moveToFertigation/move_to_fertigation_screen.dart';
import 'package:farmeasy/screens/seedingProcess/movingToGermination/moving_to_germination.dart';
import 'package:farmeasy/screens/seedingProcess/seedingTrays/seeding_trays_screen.dart';
import 'package:farmeasy/screens/tab/seeding/seeding_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base/utils/constants.dart';
import '../../screens/tab/cycles/provider/cycles_provider.dart';

final seedingStatusProvider = StateProvider<SeedingStatus>((ref) {
  return SeedingStatus.idle;
});

enum SeedingStatus { idle, started, issueMarked }

class CustomSeedingActionSection extends StatelessWidget {
  final String buttonText;
  final CycleStage currentStage;

  CustomSeedingActionSection({super.key, required this.buttonText,required this.currentStage});

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
                onPressed: () {
                  navigateToStage(context,currentStage);
                },
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
void navigateToStage(BuildContext context, CycleStage stage) {
  switch (stage) {
    case CycleStage.seeding:
      moveToNextScreen(context,SeedingTraysScreen.route,stage);
      break;
    case CycleStage.movement:
      moveToNextScreen(context,SeedingScreenPage.route,stage);
      break;
    case CycleStage.germination:
      moveToNextScreen(context,MovingToGerminationScreen.route,stage);
      break;
    case CycleStage.fertigation:
      moveToNextScreen(context,MoveToFertigationScreen.route,stage);
      break;
    case CycleStage.harvesting:
      moveToNextScreen(context,HarvestingTraysScreens.route,stage);
      break;
  }
}

void moveToNextScreen(BuildContext context,String routeName, CycleStage stage) {
  context.navigator.pushNamed(
    routeName,
    arguments: {cycleStageArgumentName: stage},
  );
}



