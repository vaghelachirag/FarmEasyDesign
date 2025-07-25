import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../tab/cycles/provider/cycles_provider.dart';

class ConfirmHarvestingTrayDetail extends ConsumerStatefulWidget {
  static const route = "/HarvestingTraysScreens";

  const ConfirmHarvestingTrayDetail({super.key});

  @override
  ConsumerState<ConfirmHarvestingTrayDetail> createState() => _ConfirmHarvestingTrayDetail();
}

class _ConfirmHarvestingTrayDetail extends ConsumerState<ConfirmHarvestingTrayDetail>
    with TickerProviderStateMixin {


  late CycleStage cycleStatus;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    final isVisibleAddDetail = ref.watch(isHarvestDueProvider);
    final addDetailStateNotifier = ref.read(isHarvestDueProvider.notifier);

    getArgument();

    return SafeArea(child: Scaffold(
      appBar: getActionbar("Harvesting Trays"),
      body:  SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              StepProgressIndicator(currentStepName: cycleStatus),
              10.verticalSpace,
              isVisibleAddDetail == false ? _loadMainWidget(showScanner,toggleScanner,scanState,scanStateNotifier,addDetailStateNotifier) : AssignHarvestingTray(),
            ],
          ),
        ),
      ),
    ));
  }

  // Load Main Widget
  Widget _loadMainWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier,StateController<bool> addDetailStateNotifier ){
    return  scanState == ScanState.confirmDetail? _nutritionInfoWidget(addDetailStateNotifier) : _scannerInfoCard(showScanner,toggleScanner,scanState,scanStateNotifier,addDetailStateNotifier);
  }
  Widget _nutritionInfoWidget(StateController<bool> addDetailStateNotifier){
    return Container(
      width: double.infinity,
      decoration: boxDecoration(AppColors.scanQrMainBg,AppColors.scanQrMainBg),
      padding: EdgeInsets.all(0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTabConfirmDetailMoveToFertigation(),
          10.verticalSpace,
          _trayInfoContainer(),
          10.verticalSpace,
          CustomNutrientInfoCardWidget(),
          20.verticalSpace,
          CustomNutrietionTimeLineWidget(),
          20.verticalSpace,
          _manualCheckWidget(addDetailStateNotifier)
        ],
      ),
    );
  }

  Widget _scannerInfoCard(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier, StateController<bool> addDetailStateNotifier){
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
          _nextActionButton(context,ref,scanStateNotifier,addDetailStateNotifier),
        ],
      ),
    );
  }

  Widget _trayInfoContainer(){
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.all(10.w),
      decoration: AppDecorations.seedingMainBg(),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("Tray Information",style: context.textTheme.labelLarge?.copyWith(fontSize: 12.sp,color: AppColors.blackColor),),
          Text("Tray Information",style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
          12.verticalSpace,
          // Tray Details
          Text( "Tray Details:",style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
          Text("8 Arugula Tray | 9 Gms",style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
          12.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( "Tray Position:",style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
                    Text("Zone 5 | Section 4 |",style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
                    Text("Level 3",style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
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
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Status:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Germination"),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildDateBadge("Since 25/05/2025"),
            ],
          ),
          20.verticalSpace,
          CustomHarvestReminderCard(),
        ],
      ),
    );
  }

  // Show Next Action Button
  Widget _nextActionButton (BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier, StateController<bool> addDetailStateNotifier){
    return Consumer(
      builder: (context, ref, _) =>  nextActionButton(context,ref,scanStateNotifier,addDetailStateNotifier),
    );
  }


  // Add Detail button
  Widget nextActionButton(BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier, StateController<bool> addDetailStateNotifier){
    final scanState = ref.watch(scanStateProvider);
    return scanState == ScanState.scanning?  Align(
        alignment: Alignment.topRight,
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                width: 120.h,
                child:  ScanMoreCustomButton(btnName: context.l10n.scanMore, onPressed: (){
                  scanStateNotifier.state =  ScanState.scanning;
                })
            ),
            10.horizontalSpace,
            SizedBox(
              width: 120.w,
              child: CustomAddDetailButton(btnName: "Next", onPressed: () {
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
          Text( "Complete Harvest before • 22:00 Today",style: context.textTheme.labelMedium?.copyWith(fontSize: 11.sp,color: AppColors.infoTextHingBg),),
          10.verticalSpace,
          SizedBox(
            width: double.infinity,
            child:
            CustomAddDetailButton(btnName: "Add Details", iconPath: Assets.icons.iconAddDetail.path, onPressed: (){
              addDetailStateNotifier.state = true;
            }),
          ),
          const SizedBox(height: 12),
          // Manual Check Button (Outlined),
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
      label: labelTextRegular("Manual Check", 12.sp, AppColors.blackColor),
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