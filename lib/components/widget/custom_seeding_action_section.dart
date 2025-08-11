import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/components/widget/common_widget_total_ppm.dart';
import 'package:farmeasy/components/widget/custom_tab_confirm_detail_move_to_fertigation.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/seedingProcess/harvestingTrays/harvesting_trays_screens.dart';
import 'package:farmeasy/screens/seedingProcess/moveToFertigation/move_to_fertigation_screen.dart';
import 'package:farmeasy/screens/seedingProcess/movingToGermination/moving_to_germination.dart';
import 'package:farmeasy/screens/seedingProcess/seedingTrays/seeding_trays_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base/utils/constants.dart';
import '../../base/utils/custom_add_detail_button.dart';
import '../../model/model_cycle.dart';
import '../../screens/seedingProcess/moveToFertigation/totalPpm/TotalPpmCard.dart';
import '../../screens/tab/cycles/provider/cycles_provider.dart';
import 'common_harvesting_now_button.dart';
import 'custom_lifecycle_fertigation_current_stage.dart';
import 'custom_nutrient_info_card_widget.dart';
import 'custom_nutrietion_time_line_widget.dart';

final seedingStatusProvider = StateProvider<SeedingStatus>((ref) {
  return SeedingStatus.idle;
});

enum SeedingStatus { idle, started, issueMarked }

class CustomSeedingActionSection extends StatelessWidget {
  final String buttonText;
  final CycleStage currentStage;
  final ModelCycle modelCycle;

  const CustomSeedingActionSection({super.key, required this.buttonText,required this.currentStage,required this.modelCycle});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return  switch (currentStage) {
      CycleStage.seeding => loadCycleButtonWidget(context,currentStage,buttonText),
      CycleStage.germination => loadCycleButtonWidget(context,currentStage,buttonText),
      CycleStage.moveToFertigation => loadCycleButtonWidget(context,currentStage,buttonText),
      CycleStage.harvesting => loadCycleButtonWidget(context,currentStage,buttonText),
      CycleStage.fertigation => loadFertigationWidget(context,modelCycle)
    };
  }
}
void navigateToStage(BuildContext context, CycleStage stage) {
  switch (stage) {
    case CycleStage.seeding:
      moveToNextScreen(context,SeedingTraysScreen.route,stage);
      break;
    case CycleStage.germination:
      moveToNextScreen(context,MovingToGerminationScreen.route,stage);
      break;
    case CycleStage.moveToFertigation:
      moveToNextScreen(context,MoveToFertigationScreen.route,stage);
      break;
    case CycleStage.harvesting:
      moveToNextScreen(context,HarvestingTraysScreens.route,stage);
      break;
    case CycleStage.fertigation:
      moveToNextScreen(context,MoveToFertigationScreen.route,stage);
  }
}

Widget loadCycleButtonWidget(BuildContext context, CycleStage currentStage, String buttonText){
  return  Column(
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
  );
}

Widget loadFertigationWidget(BuildContext context, ModelCycle modelCycle){
  return Column(
    children: [
      10.verticalSpace,
      CustomTabConfirmDetailMoveToFertigation(),
      20.verticalSpace,
      trayInfoContainer(context,AppColors.trayInfoCycleBg,AppColors.trayInfoCycleBorderBg),
      20.verticalSpace,
      CustomNutrientInfoCardWidget(),
      20.verticalSpace,
      modelCycle.isTotalPpm ? CommonWidgetTotalPpm() : TotalPpmCard(),
      20.verticalSpace,
      CustomLifecycleFertigationCurrentStage(),
      20.verticalSpace,
      bottomButtonWidget(context)
    ],
  );
}

Widget bottomButtonWidget(BuildContext context){
  return Column(
   children: [
     Text( 'Complete Harvest before • 22:00 Today',style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.infoTextHingBg)),
     10.verticalSpace,
     SizedBox(width: double.infinity,child:
     CustomerHarvestingNowButton(
     btnName: "Harvest Now",
     iconPath: Assets.icons.confirmHarvest.path,
     onPressed: (){},
      backgroundColor: AppColors.selectedProgressBg,
    buttonHeight: 5.sp,
      textColor: AppColors.white, iconColor: AppColors.white,
      )),
     10.verticalSpace,
     SizedBox(width: double.infinity,child:
     CustomerHarvestingNowButton(
       btnName: "Move Trays",
       iconPath: Assets.icons.moveToFertigation.path,
       onPressed: (){},
       backgroundColor: AppColors.markAsReadButtonBg,
       buttonHeight: 3.sp,
       textColor: AppColors.infoTextHingBg, iconColor: AppColors.infoTextHingBg,
     )),
     10.verticalSpace,
     SizedBox(width: double.infinity,child:
     CustomerHarvestingNowButton(
       btnName: "Manual Check",
       iconPath: Assets.icons.iconManualCheck.path,
       onPressed: (){},
       backgroundColor: AppColors.manualCheckButtonBg,
       buttonHeight: 3.sp,
       textColor: AppColors.infoTextHingBg, iconColor: AppColors.infoTextHingBg,
     )),
   ],
  );
}
Widget _moveTrayWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: buttonWithIcon(
            context: context,
            path: Assets.icons.iconManualCheck.path,
            label: 'Move Trays',
            onPressed: () {
              // Handle move trays action
            },
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: buttonWithIcon(
            context: context,
            path: Assets.icons.iconManualCheck.path,
            label: 'Manual Check',
            onPressed: () {
              // Handle manual check action
            },
          ),
        ),
      ],
    ),
  );
}

Widget currentNutritionTimeLineWidget(BuildContext context){
  return Container(
    padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.w),
    decoration: AppDecorations.seedingMainBg(AppColors.trayInfoPopupBg,AppColors.trayInfoCycleBorderBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        CustomNutrietionTimeLineWidget()
      ],
    ),
  );
}

void moveToNextScreen(BuildContext context,String routeName, CycleStage stage) {
  context.navigator.pushNamed(
    routeName,
    arguments: {cycleStageArgumentName: stage},
  );
}



