import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/model/model_cycle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/base/utils/common_widgets.dart' hide infoWindow;
import 'package:intl/intl.dart';

import '../../../base/utils/app_decorations.dart';
import '../../../base/utils/constants.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/dashline.dart';
import '../../../base/utils/dialougs.dart';
import '../../../components/common/app_text_styles.dart';
import '../../../components/widget/common_harvesting_now_button.dart';
import '../../../components/widget/common_trayinfo_card_fertigation_widget.dart';
import '../../../components/widget/custom_cycle_assign_person.dart';
import '../../../components/widget/custom_cycle_step_progress_bar.dart';
import '../../../components/widget/custom_lifecycle_fertigation_current_stage.dart';
import '../../../components/widget/custom_steper_widget.dart';
import '../../../components/widget/custom_tab_confirm_detail_move_to_fertigation.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';
import '../../tab/cycles/cycles_page.dart';
import '../../tab/seeding/provider/seeding_provider.dart';



class MoveToGerminationDetail extends ConsumerStatefulWidget {

  const MoveToGerminationDetail({super.key});


  @override
  ConsumerState<MoveToGerminationDetail> createState() => _MoveToGerminationDetail();
}

class _MoveToGerminationDetail extends ConsumerState<MoveToGerminationDetail> with TickerProviderStateMixin {

  late ModelCycle modelCycle;

  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(scanStateProvider.notifier).state = ScanState.idle;
    });
  }

  @override
  Widget build(BuildContext context) {


    getArgument();

    final progress = calculateProgress(modelCycle);
    final progressPercentage = calculateProgressPercentage(modelCycle);

    String formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);


    return SafeArea(child:
    Scaffold(
        appBar: getActionbar(context,""),
        body:   SingleChildScrollView(child: Card(
    child: Container(
    padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mainSeedingWidget(showScanner,toggleScanner,scanState,scanStateNotifier,formatDate)
        ],
      ),
    ),
    ))));
  }

  // Main Widget for Load Seeding page
  Widget mainSeedingWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier, String Function(DateTime date) formatDate){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.verticalSpace,
        Row(
          children: [
            Text(modelCycle.cycleName,style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 12.sp,color: AppColors.cycleTrayBg),),
            8.horizontalSpace,
            Expanded(
                child:
                Text(modelCycle.trayInfo,style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 15.sp,color: AppColors.blackColor),)
            ),
            SvgPicture.asset(
                Assets.icons.iconArrowRight// Optional: set size
            ),
          ],
        ),
        3.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Started Date • ${formatDate(modelCycle.startDate)}',style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 10.sp,color: AppColors.cycleDateTextBg),),
            Text('Est End Date • ${formatDate(modelCycle.startDate)}',style:  AppTextStyles.robotoBodyRegular.copyWith(fontSize: 10.sp,color: AppColors.cycleDateTextBg),),
          ],
        ),
        10.verticalSpace,
        StepperWidget(cycle: modelCycle),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(S.of(context).upcomingSeedingIn,style:  AppTextStyles.robotoBodyRegular.copyWith(fontSize: 10.sp,color: AppColors.upComingSeedsTextBg),),
            5.horizontalSpace,
            Container(
                decoration: AppDecorations.seedingMainBg(AppColors.startSeedsMainBg,AppColors.startSeedsBorderBg),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child:     Text('${modelCycle.arugulaTotal.toString()}${S.of(context).days}',style:  AppTextStyles.robotoBodyRegular.copyWith(fontSize: 10.sp,color: AppColors.blackColor),)
            ),
          ],
        ),
        10.verticalSpace,
        CustomCycleStepProgressBar(cycle: modelCycle),
        5.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child:
            Text("10%",style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.daysToCompleteBg))),
            Text("14 Days",style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 12.sp,color: AppColors.blackColor)),
            5.horizontalSpace,
            Text(S.of(context).toComplete,style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 10.sp,color: AppColors.daysToCompleteBg)),
          ],
        ),
        10.verticalSpace,
       _seedingInfoContainer(modelCycle,context),
        10.verticalSpace,
        bottomButtonFertigationWidget(context)
      ],
    );
  }

  Widget _seedingInfoContainer(ModelCycle cycle, BuildContext context){
    return Container(
      padding: EdgeInsets.only(left: 5.w,right: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cycle.status,style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 14.sp,color: AppColors.seedingTextBg)),
          5.verticalSpace,
          trayInfo(),
          5.verticalSpace,
          trayInfo(),
          5.verticalSpace,
          CustomCycleAssignPerson(
            onAssignTap: () {
            },
          ),
          5.verticalSpace,
          DashedLine(),
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
          20.verticalSpace,
          CustomLifecycleFertigationCurrentStage(),
        ],
      ),
    );
  }


  Widget bottomButtonFertigationWidget(BuildContext context){
    return Column(
      children: [
        Text( 'Complete Harvest before • 22:00 Today',style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.infoTextHingBg)),
        10.verticalSpace,
        SizedBox(width: double.infinity,child:
        CustomerHarvestingNowButton(
          btnName: "Move to Germination",
          iconPath: Assets.icons.iconGermination,
          onPressed: (){
            context.navigator.pushNamed(
              movingToGerminationScreen,
              arguments: {cycleStageArgumentName: modelCycle.currentStage},
            );
          },
          backgroundColor: AppColors.selectedProgressBg,
          buttonHeight: 5.sp,
          textColor: AppColors.white, iconColor: AppColors.white,
        )),
        10.verticalSpace,
        SizedBox(width: double.infinity,child:
        CustomerHarvestingNowButton(
          btnName: "Manual Check",
          iconPath: Assets.icons.iconManualCheck,
          onPressed: (){},
          backgroundColor: AppColors.manualCheckButtonBg,
          buttonHeight: 5.sp,
          textColor: AppColors.infoTextHingBg, iconColor: AppColors.infoTextHingBg,
        )),
        10.verticalSpace,
      ],
    );
  }

  void getArgument() {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    modelCycle = args[cycleStageArgumentName];
  }
}
// Success Widget
Widget scanSuccessWidget(BuildContext context){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        width: 100.h,
        height: 100.h,
        Assets.images.scanSucess,
        placeholderBuilder: (context) =>
        const CircularProgressIndicator(),
        fit: BoxFit.contain,
      ),
    ],
  );
}


// Add Detail button
Widget confirmAndSaveButton(BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier){
  final scanState = ref.watch(scanStateProvider);
  return scanState == ScanState.idle  ? const SizedBox.shrink() : SizedBox(
    width: double.infinity,
    child: CustomAddDetailButton(
      iconPath: Assets.icons.iconScanNow,
      btnName: context.l10n.confirmScanNextLevelQr,
      onPressed: () {
        //  scanStateNotifier.state = ScanState.confirmDetail;
        showTraySuccessDialog(context,false,false);
      },
    ),
  ) ;
}