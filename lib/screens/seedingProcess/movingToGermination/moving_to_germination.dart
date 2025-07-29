import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart' hide infoWindow;

import '../../../base/utils/constants.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/dialougs.dart';
import '../../../base/utils/utils.dart';
import '../../../components/widget/step_progress_widget.dart';
import '../../../generated/l10n.dart';
import '../../../generator/assets.gen.dart';
import '../../tab/seeding/provider/seeding_provider.dart';


class MovingToGerminationScreen extends ConsumerStatefulWidget {
  static const route = "/MovingToGerminationScreen";

  const MovingToGerminationScreen({super.key});


  @override
  ConsumerState<MovingToGerminationScreen> createState() => _MovingToGerminationScreen();
}

class _MovingToGerminationScreen extends ConsumerState<MovingToGerminationScreen> with TickerProviderStateMixin {

  late CycleStage cycleStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils.hideKeyboard(context);

    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    getArgument();

    return
      SafeArea(child:
    Scaffold(
      appBar: getActionbar(context,context.l10n.movingToGermination),
      body:   SizedBox(
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
            20.verticalSpace,
            _confirmAndSaveButton(context,ref)
          ],
        ),
      ),
    ),
    ));
  }

  // Load Main Widget
  Widget _loadMainWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier){
    return  Container(
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
          _showActionRequiredSection(scanState),
        ],
      ),
    );
  }

  // Show Action Required Section
  Widget _showActionRequiredSection(ScanState scanState){
    return   Visibility(
        visible: scanState == ScanState.success ,
        child:   showActionRequiredSection(context));
  }

  // Load Info Window
  Widget _loadInfoWidow(){
    return  Consumer(
      builder: (context, ref, _) => infoWidowForScan(context, cycleStatus,ref),
    );
  }

  // Show Confirm And Save Button
  Widget _confirmAndSaveButton (BuildContext context, WidgetRef ref){
    return Consumer(
      builder: (context, ref, _) =>  confirmAndSaveButton(context,ref),
    );
  }

  void getArgument() {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cycleStatus = args[cycleStageArgumentName];
  }
}

Widget showActionRequiredSection(BuildContext context){
  return  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelTextMedium(context.l10n.actionRequired, 16.sp, AppColors.blackColor),
          6.verticalSpace,
          Row(
            children: [
              Expanded(
                child:
                labelTextRegular( context.l10n.youAreTryingToAddTraysBeyondTheAvailableTray, 12.sp, AppColors.navBarUnselectedColor)
              ),
              SvgPicture.asset(Assets.icons.iconInfo.path)
            ],
          ),
          12.verticalSpace,
          Container(
            decoration:  AppDecorations.infoWindowBg(),
            padding:  EdgeInsets.all(12.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.icons.iconInfoBlub.path),
                8.verticalSpace,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(text: S.of(context).thisLevelHasOnly),
                        TextSpan(
                          text: S.of(context).fiveAvailable,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: S.of(context).traySpaceYouCanConfirmThisPositionForFirst),
                        TextSpan(
                          text: S.of(context).five,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: S.of(context).scannedTraysAndScanANewLevelQrForRemaining),
                        TextSpan(
                          text: S.of(context).threetrays,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
  );
}

// Success Widget
Widget scanSuccessWidget(BuildContext context){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        width: 100.h,
        height: 100.h,
        Assets.images.scanSucess.path,
        placeholderBuilder: (context) =>
        const CircularProgressIndicator(),
        fit: BoxFit.contain,
      ),
    ],
  );
}


// Add Detail button
Widget confirmAndSaveButton(BuildContext context, WidgetRef ref){
  final scanState = ref.watch(scanStateProvider);
  return scanState == ScanState.success ? SizedBox(
    width: double.infinity,
    child: CustomAddDetailButton(
      iconPath: Assets.icons.iconScanNow.path,
      btnName: context.l10n.confirmScanNextLevelQr,
      onPressed: () {
        showTraySuccessDialog(context);
      },
    ),
  ) : Container();
}