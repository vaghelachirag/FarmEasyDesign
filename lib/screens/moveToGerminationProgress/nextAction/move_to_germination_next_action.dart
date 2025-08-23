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
import '../../../components/widget/step_progress_widget.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';
import '../../tab/cycles/cycles_page.dart';
import '../../tab/seeding/provider/seeding_provider.dart';


class MoveToGerminationNextAction extends ConsumerStatefulWidget {
  const MoveToGerminationNextAction({super.key});

  @override
  ConsumerState<MoveToGerminationNextAction> createState() => _MoveToGerminationNextAction();
}

class _MoveToGerminationNextAction extends ConsumerState<MoveToGerminationNextAction> with TickerProviderStateMixin {

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
        appBar: getActionbar(context,"Move to Fertigation"),
        body:   SingleChildScrollView(child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainSeedingWidget(showScanner,toggleScanner,scanState,scanStateNotifier,formatDate)
            ],
          ),
        ))));
  }

  // Main Widget for Load Seeding page
  Widget mainSeedingWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier, String Function(DateTime date) formatDate){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepProgressIndicator(currentStepName: modelCycle.currentStage),
        5.verticalSpace,
        _seedingInfoContainer(modelCycle,context),
        10.verticalSpace,
        bottomButtonFertigationWidget(context)
      ],
    );
  }

  Widget _seedingInfoContainer(ModelCycle cycle, BuildContext context){
    return Container(
      decoration:  BoxDecoration(
        color: AppColors.enterPpfTextAreaLabelBg,
        borderRadius: BorderRadius.circular(12.r)),
      margin: EdgeInsets.only(left: 5.w,right: 5.w),
      padding: EdgeInsets.only(left: 5.w,right: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          CustomTabConfirmDetailMoveToFertigation(),
          10.verticalSpace,
          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: AppDecorations.fertigationTrayInfoBg(),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Text('Tray Information',style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 14.sp)),
                8.verticalSpace,
                trayTextWidget("Tray Details:","8 Arugula Tray | 9 Gms ",context),
                8.verticalSpace,
                trayTextWidget("Tray Position: ","Zone 3 | Section 4 | Level 3 ",context),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    trayTextWidget(S.of(context).currentStatus,S.of(context).harvest,context),
                    updateTodayWidget(context, "Since 25/05/2025")
                  ],
                ),
              ],
            ),
          ),
          20.verticalSpace,
          CustomLifecycleFertigationCurrentStage(withDecoration: false,),
        ],
      ),
    );
  }


  Widget bottomButtonFertigationWidget(BuildContext context){
    return Padding(padding: EdgeInsetsGeometry.only(left: 5.w,right: 5.w),child: Column(
      children: [
        10.verticalSpace,
        SizedBox(width: double.infinity,child:
        CustomerHarvestingNowButton(
          btnName: "Move to Fertigation",
          iconPath: Assets.icons.fertigationMove,
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
          btnName: "Mark Issue",
          iconPath: Assets.icons.iconManualCheck,
          onPressed: (){},
          backgroundColor: AppColors.markAsReadButtonBg,
          buttonHeight: 5.sp,
          textColor: AppColors.infoTextHingBg, iconColor: AppColors.infoTextHingBg,
        )),
        10.verticalSpace,
      ],
    ));
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