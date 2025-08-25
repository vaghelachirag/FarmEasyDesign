import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/screens/process/stepProcess/scanFlowHeaderMovingTray.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/base/utils/common_widgets.dart' hide infoWindow;
import '../../../base/utils/constants.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/dialougs.dart';
import '../../../generator/assets.gen.dart';
import '../../tab/seeding/provider/seeding_provider.dart';
import '../stepProcess/stepConfigMovingTray.dart';


class MoveTraysScreen extends ConsumerStatefulWidget {
  const MoveTraysScreen({super.key});

  @override
  ConsumerState<MoveTraysScreen> createState() => _MoveTraysScreen();
}

class _MoveTraysScreen extends ConsumerState<MoveTraysScreen> with TickerProviderStateMixin {
  late CycleStage cycleStatus;
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(scanStateProvider.notifier).state = ScanState.idle;
    });
  }

  @override
  Widget build(BuildContext context) {

    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    getArgument();

    return SafeArea(child:
    Scaffold(
        appBar: getActionbar(context,context.l10n.moveToFertigation),
        body:  mainWidgetForSeedingContainer(mainSeedingWidget(showScanner,toggleScanner,scanState,scanStateNotifier)),
        bottomNavigationBar: _loadBottomConfirmAndScanButton(scanState,scanStateNotifier)));
  }

  Widget _bottomButtonWithIconAndText(ScanState scanState, StateController<ScanState> scanStateNotifier, String path, String buttonTitle,) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: CustomAddDetailButton(
        iconPath: path,
        btnName: buttonTitle,
        onPressed: () {
          switch (scanState) {
            case ScanState.success:
            // Move to confirm details
              scanStateNotifier.state = ScanState.confirmDetail;
              ref.read(stepControllerProvider.notifier).completeAndNext();
              break;

            case ScanState.moveToFertigation:
              scanStateNotifier.state = ScanState.scanNextQR;
              break;

            case ScanState.scanNextQR:
              showTraySuccessDialog(context, false, true);

              // Optionally, mark next step complete too:
              ref.read(stepControllerProvider.notifier).completeAndNext();
              break;

            case ScanState.confirmDetail:
              showTraySuccessDialog(context, false, true);

              // If you want to finalize stepper here too:
              ref.read(stepControllerProvider.notifier).completeAndNext();
              break;

            default:
            // Handle unexpected states if needed
              break;
          }
        },
      ),
    );
  }

  Widget _loadBottomConfirmAndScanButton(ScanState scanState, StateController<ScanState> scanStateNotifier){
    return Container(
      child: switch (scanState) {
        ScanState.idle => bottomSizeBox(),
        ScanState.scanning =>  bottomSizeBox(),
        ScanState.success => _bottomButtonWithIconAndText(scanState,scanStateNotifier, Assets.icons.iconScanNow.path,"Confirm & Scan next Level QR"),
        ScanState.confirmDetail => _bottomButtonWithIconAndText(scanState,scanStateNotifier, Assets.icons.iconConfirmSave.path,"Confirm & Save"),
        ScanState.moveToFertigation => _bottomButtonWithIconAndText(scanState,scanStateNotifier, Assets.icons.iconScanNow.path,"Confirm & Scan next Level QR"),
        ScanState.scanNextQR => _bottomButtonWithIconAndText(scanState,scanStateNotifier, Assets.icons.iconConfirmSave.path,"Confirm & Save"),
        _ => Text('Unknown Status'),
      },
    );
  }

  // Main Widget for Load Seeding page
  Widget mainSeedingWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScanFlowHeaderMovingTray(),
        10.verticalSpace,
        _loadMainWidget(showScanner,toggleScanner,scanState,scanStateNotifier),
        20.verticalSpace,
      ],
    );
  }

  // Load Main Widget
  Widget _loadMainWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier){
    return  Container(
      child: switch (scanState) {
        ScanState.idle => _loadIdealContainer(showScanner,toggleScanner,scanState,scanStateNotifier),
        ScanState.scanning => _loadIdealContainer(showScanner,toggleScanner,scanState,scanStateNotifier),
        ScanState.success => _loadIdealContainer(showScanner,toggleScanner,scanState,scanStateNotifier),
        ScanState.confirmDetail =>   loadAddingTrayContainer(context,true),
        ScanState.moveToFertigation => _loadIdealContainer(showScanner,toggleScanner,scanState,scanStateNotifier),
        ScanState.scanNextQR => loadAddingTrayContainer(context,true),
        _ => Text('Unknown Status'),
      },
    );
  }

  Widget _loadIdealContainer(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier){
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

  void getArgument() {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cycleStatus = args[cycleStageArgumentName];
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
        Assets.images.scanSucess.path,
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
      iconPath: Assets.icons.iconScanNow.path,
      btnName: context.l10n.confirmScanNextLevelQr,
      onPressed: () {
        //  scanStateNotifier.state = ScanState.confirmDetail;
        showTraySuccessDialog(context,false,false);
      },
    ),
  ) ;
}