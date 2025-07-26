import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/components/widget/custom_nutrient_info_card_widget.dart';
import 'package:farmeasy/screens/seedingProcess/harvestingTrays/manualCheck/manual_check_screen.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../base/utils/constants.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../components/widget/custom_nutrietion_time_line_widget.dart';
import '../../../components/widget/custom_tab_confirm_detail_move_to_fertigation.dart';
import '../../../components/widget/step_progress_widget.dart';
import '../../../generator/assets.gen.dart';
import '../../tab/seeding/provider/seeding_provider.dart';


class MoveToFertigationScreen extends ConsumerStatefulWidget {
  static const route = "/MoveToFertigationScreen";

  const MoveToFertigationScreen({super.key});

  @override
  ConsumerState<MoveToFertigationScreen> createState() => _MoveToFertigationScreen();
}

class _MoveToFertigationScreen extends ConsumerState<MoveToFertigationScreen>
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

    getArgument();

    return SafeArea(child: Scaffold(
      appBar: getActionbar("Move to Fertigation"),
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
              _loadMainWidget(showScanner,toggleScanner,scanState,scanStateNotifier),
            ],
          ),
        ),
      ),
    ));
  }

  // Load Main Widget
  Widget _loadMainWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier){
    return  scanState == ScanState.confirmDetail? Container(
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
          _moveToFertigationWidget(context),
        ],
      ),
    ) : Container(
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
          _nextActionButton(context,ref,scanStateNotifier),
        ],
      ),
    );
  }

  Widget _moveToFertigationWidget(BuildContext context){
    return   Container(
      padding: EdgeInsets.all(10.w),
      decoration: AppDecorations.manualCheckDecorationBg(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child:
            CustomAddDetailButton(btnName: "Move to Fertigation", iconPath: Assets.icons.moveToFertigation.path, onPressed: (){
              print("Manual"+"Manual");
              context.navigator.pushNamed(ManualCheckScreen.route);
            }),
          ),
          12.verticalSpace,
          _moveTrayWidget()
        ],
      ),
    );
  }

  Widget  _moveTrayWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child:
        buttonWithIcon(
          context: context,
          path: Assets.icons.iconManualCheck.path, // Move Trays
          label: 'Move Trays',
          onPressed: () {
            // Handle move trays action
          },
        )),
        const SizedBox(width: 16),
        Expanded(child: buttonWithIcon(
          context: context,
          path: Assets.icons.iconManualCheck.path, // Manual Check
          label: 'Manual Check',
          onPressed: () {
            // Handle manual check action
          },
        )),
      ],
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
          // Tray Position + Date Badge
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
        ],
      ),
    );
  }

  // Show Next Action Button
  Widget _nextActionButton (BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier){
    return Consumer(
      builder: (context, ref, _) =>  nextActionButton(context,ref,scanStateNotifier),
    );
  }


  // Add Detail button
  Widget nextActionButton(BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier){
    final scanState = ref.watch(scanStateProvider);
    return scanState == ScanState.scanning?  Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 100.w,
        child: CustomAddDetailButton(btnName: "Next", onPressed: () {
          scanStateNotifier.state = ScanState.confirmDetail;
        },iconPath: Assets.icons.iconNext.path),
      ),
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

  Widget _manualCheckWidget(){
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: AppDecorations.manualCheckDecorationBg(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text( "Complete Harvest before • 22:00 Today",style: context.textTheme.labelMedium?.copyWith(fontSize: 11.sp,color: AppColors.infoTextHingBg),),
          10.verticalSpace,
          SizedBox(
            width: double.infinity,
            child:
            CustomAddDetailButton(btnName: "Add Details", iconPath: Assets.icons.iconAddDetail.path, onPressed: (){
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