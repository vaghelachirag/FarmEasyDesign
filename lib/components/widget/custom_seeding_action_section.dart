import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:farmeasy/components/widget/common_next_action_button.dart';
import 'package:farmeasy/components/widget/common_trayinfo_card_fertigation_widget.dart';
import 'package:farmeasy/components/widget/common_widget_total_ppm.dart';
import 'package:farmeasy/components/widget/custom_tab_confirm_detail_move_to_fertigation.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base/utils/constants.dart';
import '../../generated/l10n.dart';
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
      CycleStage.germination => loadGerminationWidget(context,currentStage,buttonText,),
      CycleStage.moveToFertigation => loadCycleButtonWidget(context,currentStage,buttonText),
      CycleStage.harvesting => loadCycleButtonWidget(context,currentStage,buttonText),
      CycleStage.fertigation => FertigationWidget(currentStage: currentStage,buttonText: buttonText,modelCycle: modelCycle),
      CycleStage.moveToGermination => loadMoveToGerminationWidget(context)
    };
  }
}

Widget loadGerminationWidget(BuildContext context, CycleStage currentStage, String buttonText){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
         8.verticalSpace,
         Text("Next Action", style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 14.sp,color: AppColors.blackColor),),
          5.verticalSpace,
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text("This Trays are currently in Germination.", style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 10.sp,color: AppColors.infoTextHingBg)),
              SizedBox(width: 15.w,height: 15.h,child:SvgPicture.asset(Assets.icons.iconInfo.path))
           ],
         ),
        8.verticalSpace,
         CommonNextActionButton(
        description: "For Arugula Trays the Germination time after seeding is 54 Hours.",
        days: "01",
        hours: "12",
        minutes: "36",
        moveDate: "21 Jul, 08:00 AM",
        ),
        // 🔹 Your new block starts here
        10.verticalSpace,
        Center(child:
        Text(S.of(context).completeSeedingBefore2200Today,style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.infoTextHingBg),)),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child:
            CustomerHarvestingNowButton(
              btnName: "Move to Fertigation",
              iconPath: Assets.icons.iconTemperature.path,
              onPressed: (){},
              backgroundColor: AppColors.primary,
              buttonHeight: 1.sp,
              textColor: AppColors.white, iconColor: AppColors.white,
            )),
            5.horizontalSpace,
            Expanded(child:
            CustomerHarvestingNowButton(
          btnName: "Manual Check",
          iconPath: Assets.icons.iconManualCheck.path,
          onPressed: (){},
          backgroundColor: AppColors.manualCheckButtonBg,
          buttonHeight: 1.sp,
          textColor: AppColors.infoTextHingBg, iconColor: AppColors.infoTextHingBg,
        ))
          ],
        ),
        // 🔹 Your block ends here
      ]
  );
}
void navigateToStage(BuildContext context, CycleStage stage) {
  switch (stage) {
    case CycleStage.seeding:
      moveToNextScreen(context,seedingTraysScreen,stage);
      break;
    case CycleStage.germination:
      moveToNextScreen(context,movingToGerminationScreen,stage);
      break;
    case CycleStage.moveToFertigation:
      moveToNextScreen(context,moveToFertigationScreen,stage);
      break;
    case CycleStage.harvesting:
      moveToNextScreen(context,harvestingTraysScreens,stage);
      break;
    case CycleStage.fertigation:
      moveToNextScreen(context,moveToFertigationScreen,stage);
    case CycleStage.moveToGermination:
      moveToNextScreen(context,movingToGerminationScreen,stage);
  }
}

Widget loadCycleButtonWidget(BuildContext context, CycleStage currentStage, String buttonText){
  return  Column(
    children: [
      10.verticalSpace,
      Text(S.of(context).completeSeedingBefore2200Today,style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 10.sp,color: AppColors.infoTextHingBg),),
      10.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 150.w, // half screen with padding
            height: 30.h,
            child: ElevatedButton.icon(
              style: AppDecorations.startSeedingButtonStyle(),
              onPressed: () {
                navigateToStage(context,currentStage);
              },
              icon: SvgPicture.asset(
                Assets.icons.iconStartSeed.path,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              label:
              Text(buttonText,style: context.textTheme.labelLarge?.copyWith(fontSize: 12.sp,color: AppColors.white)
            ),
          )),
          20.horizontalSpace,
          Expanded(child:
          SizedBox(
            width: 120.w,
            height: 30.w,
            child: AppDecorations.markAsReadButtonStyle(context),
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
      CommonTrayInfoCardFertigationWidget(
        seedingSummary: "Seeding 30 Trays : 11 Full Trays | 19 Half Trays",
        seedLotCodes: ["#4577", "#4580", "#4599", "#4601","#4577", "#4580", "#4599", "#4601"],
        trayDetails: "30 Arugula Tray | 30 Gms/ Tray",
        coirWeight: "9 Gms",
        currentStatus: "Seeding",
        statusDate: "Since 25/05/2025",
      ),
      8.verticalSpace,
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


Widget loadMoveToGerminationWidget(BuildContext context){
  return bottomMoveToGerminationWidget(context);
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

Widget bottomButtonFertigationWidget(BuildContext context){
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomerHarvestingNowButton(
              btnName: "Move to Tray",
              iconPath: Assets.icons.iconModeTray.path,
              onPressed: () {},
              backgroundColor: AppColors.primary,
              buttonHeight: 1.sp,
              textColor: AppColors.infoTextHingBg,
              iconColor: AppColors.infoTextHingBg,
            ),
          ),
          5.horizontalSpace,
          Expanded(
            child: CustomerHarvestingNowButton(
              btnName: "Manual Check",
              iconPath: Assets.icons.iconManualCheck.path,
              onPressed: () {},
              backgroundColor: AppColors.manualCheckButtonBg,
              buttonHeight: 1.sp,
              textColor: AppColors.infoTextHingBg,
              iconColor: AppColors.infoTextHingBg,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget bottomMoveToGerminationWidget(BuildContext context){
  return Column(
    children: [
      Text( 'Complete Harvest before • 22:00 Today',style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.infoTextHingBg)),
      10.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomerHarvestingNowButton(
              btnName: "Move to Germination",
              iconPath: Assets.icons.iconMoveToGermination.path,
              onPressed: () {},
              backgroundColor: AppColors.buttonBorderColor,
              buttonHeight: 1.sp,
              textColor: AppColors.white,
              iconColor: AppColors.white,
            ),
          ),
          5.horizontalSpace,
          Expanded(
            child: CustomerHarvestingNowButton(
              btnName: "Manual Check",
              iconPath: Assets.icons.iconManualCheck.path,
              onPressed: () {},
              backgroundColor: AppColors.manualCheckButtonBg,
              buttonHeight: 1.sp,
              textColor: AppColors.infoTextHingBg,
              iconColor: AppColors.infoTextHingBg,
            ),
          ),
        ],
      ),
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

class GerminationWidget extends StatefulWidget {
  final CycleStage currentStage;
  final String buttonText;

  const GerminationWidget({
    super.key,
    required this.currentStage,
    required this.buttonText,
  });

  @override
  State<GerminationWidget> createState() => _GerminationWidgetState();
}

class _GerminationWidgetState extends State<GerminationWidget> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpace,
        GestureDetector(
          onTap: () {
            setState(() {
              _showDetails = !_showDetails;
            });
          },
          child:  Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                setState(() {
                  _showDetails = !_showDetails;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text( _showDetails ? S.of(context).hideHistory : S.of(context).viewHistory,style: context.textTheme.labelLarge?.copyWith(fontSize: 12.sp,color: AppColors.buttonBackgroundColor),),
                  4.horizontalSpace,
                  Icon(
                    _showDetails
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color:  AppColors.buttonBackgroundColor,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_showDetails) ...[
        8.verticalSpace,
        Text(
          "Next Action",
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: 14.sp,
            color: AppColors.blackColor,
          ),
        ),
        5.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "This Trays are currently in Germination.",
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10.sp,
                color: AppColors.infoTextHingBg,
              ),
            ),
            SizedBox(
              width: 15.w,
              height: 15.h,
              child: SvgPicture.asset(Assets.icons.iconInfoBlub.path),
            ),
          ],
        ),
        8.verticalSpace,
        CommonNextActionButton(
          description:
          "For Arugula Trays the Germination time after seeding is 54 Hours.",
          days: "01",
          hours: "12",
          minutes: "36",
          moveDate: "21 Jul, 08:00 AM",
        ),
          10.verticalSpace,
          Center(
            child: Text(
              'Complete Seeding before • 22:00 Today',
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10.sp,
                color: AppColors.infoTextHingBg,
              ),
            ),
          ),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomerHarvestingNowButton(
                  btnName: "Move to Fertigation",
                  iconPath: Assets.icons.iconTemperature.path,
                  onPressed: () {},
                  backgroundColor: AppColors.primary,
                  buttonHeight: 1.sp,
                  textColor: AppColors.white,
                  iconColor: AppColors.white,
                ),
              ),
              5.horizontalSpace,
              Expanded(
                child: CustomerHarvestingNowButton(
                  btnName: "Manual Check",
                  iconPath: Assets.icons.iconManualCheck.path,
                  onPressed: () {},
                  backgroundColor: AppColors.manualCheckButtonBg,
                  buttonHeight: 1.sp,
                  textColor: AppColors.infoTextHingBg,
                  iconColor: AppColors.infoTextHingBg,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class FertigationWidget extends StatefulWidget{
  final CycleStage currentStage;
  final String buttonText;
  final ModelCycle modelCycle;

  const FertigationWidget({
    super.key,
    required this.currentStage,
    required this.buttonText,
    required this.modelCycle,
  });

  @override
  State<FertigationWidget> createState() => _FertigationWidgetState();
}

class _FertigationWidgetState extends State<FertigationWidget> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpace,
        if (!_showDetails) ...[
          8.verticalSpace,
          bottomButtonFertigationWidget(context)
        ],
        10.verticalSpace,
        GestureDetector(
          onTap: () {
            setState(() {
              _showDetails = !_showDetails;
            });
          },
          child:  Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                setState(() {
                  _showDetails = !_showDetails;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text( _showDetails ? S.of(context).hideHistory : "View Details",style: context.textTheme.labelLarge?.copyWith(fontSize: 12.sp,color: AppColors.buttonBackgroundColor),),
                  4.horizontalSpace,
                  Icon(
                    _showDetails
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color:  AppColors.buttonBackgroundColor,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_showDetails) ...[
          loadFertigationWidget(context,widget.modelCycle)
        ],
      ],
    );
  }
}




