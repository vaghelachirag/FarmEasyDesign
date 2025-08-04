import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/components/widget/custom_harvest_reminder_card.dart';
import 'package:farmeasy/components/widget/custom_multiple_harvesting_tray_info.dart';
import 'package:farmeasy/screens/seedingProcess/harvestingTrays/assignHarvestingTray/assign_harvesting_tray.dart';
import 'package:farmeasy/screens/seedingProcess/harvestingTrays/provider/harvesting_trays_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';

import '../../../base/utils/constants.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/scan_more_custom_button.dart';
import '../../../base/utils/utils.dart';
import '../../../components/widget/custom_nutrient_info_card_widget.dart';
import '../../../components/widget/custom_nutrietion_time_line_widget.dart';
import '../../../components/widget/custom_tab_confirm_detail_move_to_fertigation.dart';
import '../../../components/widget/step_progress_widget.dart';
import '../../../generated/l10n.dart';
import '../../../generator/assets.gen.dart';
import '../../tab/seeding/provider/seeding_provider.dart';

class HarvestingTraysScreens extends ConsumerStatefulWidget {
  static const route = "/HarvestingTraysScreens";

  const HarvestingTraysScreens({super.key});

  @override
  ConsumerState<HarvestingTraysScreens> createState() => _HarvestingTraysScreens();
}

class _HarvestingTraysScreens extends ConsumerState<HarvestingTraysScreens>
    with TickerProviderStateMixin {


  late CycleStage cycleStatus;

  @override
  void initState() {
    super.initState();
   // Utils.hideKeyboard(context);
    Future(() {
      ref.read(scanStateProvider.notifier).state = ScanState.idle;
      ref.read(isHarvestDueProvider.notifier).state = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    final isVisibleAddDetail = ref.watch(isHarvestDueProvider);
    final addDetailStateNotifier = ref.read(isHarvestDueProvider.notifier);

    // Item Count for Scan Item
    final scannedItems = ref.watch(scannedItemsProvider);
    final itemCount = scannedItems.length;

    getArgument();

    return SafeArea(child: Scaffold(
      appBar: getActionbar(context,"Harvesting Trays"),
      body:  mainWidgetForSeedingContainer(mainSeedingWidget(showScanner,toggleScanner,scanState,scanStateNotifier,addDetailStateNotifier,itemCount,isVisibleAddDetail)),
    ));
  }

  // Main Widget for Load Seeding page
  Widget mainSeedingWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier, StateController<bool> addDetailStateNotifier, int itemCount, bool isVisibleAddDetail){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepProgressIndicator(currentStepName: cycleStatus),
        10.verticalSpace,
        isVisibleAddDetail == false ? _loadMainWidget(showScanner,toggleScanner,scanState,scanStateNotifier,addDetailStateNotifier,itemCount) : AssignHarvestingTray(cycleStatus: cycleStatus,),
        //  isVisibleAddDetail == false &&  scanState == ScanState.confirmDetail ? Container() :_manualCheckWidget(addDetailStateNotifier)
      ],
    );
  }

  // Load Main Widget
  Widget _loadMainWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier,StateController<bool> addDetailStateNotifier, int itemCount ){
    return  scanState == ScanState.confirmDetail? _nutritionInfoWidget(addDetailStateNotifier,itemCount) : _scannerInfoCard(showScanner,toggleScanner,scanState,scanStateNotifier,addDetailStateNotifier,itemCount);
  }
  Widget _nutritionInfoWidget(StateController<bool> addDetailStateNotifier, int itemCount){
    return Column(
      children: [
        Container(
      width: double.infinity,
      decoration: boxDecoration(AppColors.scanQrMainBg,AppColors.scanQrMainBg),
      padding: EdgeInsets.all(5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          itemCount > 1 ? CustomMultipleHarvestingTrayInfo() : _showSingleHarvestingWidget(),
          20.verticalSpace,
          CustomNutrietionTimeLineWidget(),
          20.verticalSpace,
        ],
      ),
    ),
        _manualCheckWidget(addDetailStateNotifier)
      ],
    );
  }

  Widget _showSingleHarvestingWidget(){
    return Column(
      children: [
        CustomTabConfirmDetailMoveToFertigation(),
        10.verticalSpace,
        trayInfoContainer(),
        10.verticalSpace,
        CustomNutrientInfoCardWidget(),
      ],
    );
  }

  Widget _scannerInfoCard(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier, StateController<bool> addDetailStateNotifier, int itemCount){
    return Container(
      decoration: boxDecoration(AppColors.scanQrMainBg,AppColors.scanQrMainBg),
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          buildTopBar(),
          20.verticalSpace,
          _loadInfoWidow(),
          40.verticalSpace,
          scanQrExpand(context,showScanner,toggleScanner,scanState,scanStateNotifier,cycleStatus),
          40.verticalSpace,
          //_showActionRequiredSection(scanState),
          _nextActionButton(context,ref,scanStateNotifier,addDetailStateNotifier,itemCount),
        ],
      ),
    );
  }

  Widget trayInfoContainer(){
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.all(10.w),
      decoration: AppDecorations.seedingMainBg(AppColors.startSeedsMainBg,AppColors.startSeedsBorderBg),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("Tray Information",style: context.textTheme.labelLarge?.copyWith(fontSize: 12.sp,color: AppColors.blackColor),),
          Text(S.of(context).trayInformation,style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
          12.verticalSpace,
          // Tray Details
          Text( S.of(context).trayDetails,style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
          Text(S.of(context).ArugulaTrayGms,style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
          12.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( S.of(context).trayPosition,style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
                    Text(S.of(context).zone5Section4,style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
                    Text(S.of(context).level3,style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
                  ],
                ),
              ),
              8.verticalSpace,
              _buildDateBadge("Moved on 25/05/2025"),
            ],
          ),
          8.verticalSpace,
          // Current Status + Date Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).currentStatus,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(S.of(context).germination),
                  ],
                ),
              ),
              8.verticalSpace,
              _buildDateBadge(S.of(context).since25052025),
            ],
          ),
          20.verticalSpace,
          CustomHarvestReminderCard(),
        ],
      ),
    );
  }

  // Show Next Action Button
  Widget _nextActionButton (BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier, StateController<bool> addDetailStateNotifier, int itemCount){
    return Consumer(
      builder: (context, ref, _) =>  nextActionButton(context,ref,scanStateNotifier,addDetailStateNotifier,itemCount),
    );
  }


  // Add Detail button
  Widget nextActionButton(BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier, StateController<bool> addDetailStateNotifier, int itemCount){
    final scanState = ref.watch(scanStateProvider);

    return scanState == ScanState.success?  Align(
      alignment: Alignment.topRight,
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
              width: 120.h,
              child:  ScanMoreCustomButton(btnName: context.l10n.scanMore, onPressed: (){
                scanStateNotifier.state =  ScanState.scanning;
                final newCode = "QR_${DateTime.now().millisecondsSinceEpoch}";
                ref.read(scannedItemsProvider.notifier).addItem(newCode);
              })
          ),
          10.horizontalSpace,
          SizedBox(
            width: 120.w,
            child: CustomAddDetailButton( btnName: itemCount > 1 ? "Next ($itemCount)" : "Next", onPressed: () {
              scanStateNotifier.state = ScanState.confirmDetail;
            },iconPath: Assets.icons.iconNext.path),
          ),
        ],
      )
    )  : Container();
  }

  // Load Info Window
  Widget _loadInfoWidow(){
    return  Consumer(
      builder: (context, ref, _) => infoWidowForScan(context, cycleStatus,ref),
    );
  }

  void getArgument() {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cycleStatus = args[cycleStageArgumentName];
  }

  Widget _manualCheckWidget(StateController<bool> addDetailStateNotifier){
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: AppDecorations.manualCheckDecorationBg(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.verticalSpace,
          Text( S.of(context).completeHarvestBefore2200Today,style: context.textTheme.labelMedium?.copyWith(fontSize: 11.sp,color: AppColors.infoTextHingBg),),
          10.verticalSpace,
          SizedBox(
            width: double.infinity,
            child:
            CustomAddDetailButton(btnName: S.of(context).addDetails, iconPath: Assets.icons.iconAddDetail.path, onPressed: (){
              addDetailStateNotifier.state = true;
            }),
          ),
          12.verticalSpace,
          SizedBox(
            width: double.infinity,
            child:   _manualCheckButton(),
          )
        ],
      ),
    );
  }

  Widget _manualCheckButton(){
    return SizedBox(width: double.infinity,height:40.w, child: ElevatedButton.icon(
      onPressed:(){},
      icon:  SvgPicture.asset(Assets.icons.iconManualCheck.path), // use appropriate icon
      label: labelTextRegular(S.of(context).manualCheck, 12.sp, AppColors.blackColor),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.manualCheckButtonBg,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
      ),
    ),);
  }

  Widget _buildDateBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: AppDecorations.trayInfoPopupBg(),
      child:
      Text(text,style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.blackColor)),
    );
  }
}