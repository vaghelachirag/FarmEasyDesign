
import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/screens/process/stepProcess/scanFlowHeaderMovingTray.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/base/utils/common_widgets.dart' hide infoWindow;
import '../../../base/utils/app_decorations.dart';
import '../../../base/utils/constants.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/dialougs.dart';
import '../../../generator/assets.gen.dart';
import '../../seedingProcess/harvestingTrays/assignHarvestingTray/assign_harvesting_tray.dart';
import '../../tab/seeding/provider/seeding_provider.dart';
import '../stepProcess/stepConfigMovingTray.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


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
          // Define steps length for the provider
          const stepsLength = 3;
          final stepController = ref.read(stepControllerProvider(stepsLength).notifier);
          
          switch (scanState) {
            case ScanState.success:
            // Move to confirm details
              scanStateNotifier.state = ScanState.confirmDetail;
              stepController.handleScanStateChange('success', stepsLength);
              break;

            case ScanState.moveToFertigation:
              scanStateNotifier.state = ScanState.scanNextQR;
              break;

            case ScanState.scanNextQR:
              showTraySuccessDialog(context, false, true);
              stepController.handleScanStateChange('scanNextQR', stepsLength);
              break;

            case ScanState.confirmDetail:
              showTraySuccessDialog(context, false, true);
              stepController.handleScanStateChange('confirmDetail', stepsLength);
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
    return Container(
      decoration: boxDecoration(AppColors.scanQrMainBg,AppColors.scanQrMainBg),
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          buildTopBar(),
          20.verticalSpace,
          _loadInfoWidow(),
          40.verticalSpace,
          // Use custom scan container for moving tray
          Center(
            child: GestureDetector(
              onTap: () {
                scanStateNotifier.state = ScanState.scanning;
              },
              child: SizedBox(
                height: 240.h,
                width: 240.w,
                child: Stack(
                  children: [
                    // Corner Decorations (outside padding)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(Assets.images.leftSideCornerScan.path),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: SvgPicture.asset(Assets.images.iconRightTopCorner.path),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: SvgPicture.asset(Assets.images.iconLeftBottomCorner.path),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(Assets.images.iconRightBottomCorner.path),
                    ),
                    // Main Content with padding
                    Container(
                      child: customScanContainerForMovingTray(context, scanState, scanStateNotifier, ref),
                    ),
                  ],
                ),
              ),
            ),
          ),
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

// Custom mobile scanner for moving tray that handles step progression
Widget customMobileScannerForMovingTray(BuildContext context, ScanState scanState, StateController<ScanState> scanStateNotifier, WidgetRef ref) {
  return Center(
    child: Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.normal,
            facing: CameraFacing.back,
          ),
          onDetect: (BarcodeCapture barcode) {
            scanStateNotifier.state = ScanState.success;
            
            // Automatically progress to next step when scan is successful
            const stepsLength = 3;
            final stepController = ref.read(stepControllerProvider(stepsLength).notifier);
            
            // Check current step and progress accordingly
            final currentState = ref.read(stepControllerProvider(stepsLength));
            if (currentState.currentIndex == 0) {
              // First scan (Tray QR) completed
              stepController.handleInitialScanSuccess();
            } else if (currentState.currentIndex == 2) {
              // Second scan (Level QR) completed
              stepController.handleSecondScanSuccess();
            }
          },
        ),
      ),
    ),
  );
}

// Custom scan container that uses the custom mobile scanner
Widget customScanContainerForMovingTray(BuildContext context, ScanState scanState, StateController<ScanState> scanStateNotifier, WidgetRef ref) {
  return Container(
    margin: EdgeInsets.all(15),
    decoration: AppDecorations.scanQrcodeBg(),
    child: Padding(
      padding: EdgeInsets.all(20.r),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Icon
            Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.qr_code,
                size: 160.r,
              ),
            ),
            Container(
              child: switch(scanState){
                ScanState.idle => tapScanColumn(context),
                ScanState.scanning => customMobileScannerForMovingTray(context, scanState, scanStateNotifier, ref),
                ScanState.success => scanSuccessWidget(context),
                ScanState.confirmDetail => scanSuccessWidget(context),
                ScanState.moveToFertigation => tapScanColumn(context),
                ScanState.scanNextQR => null,
              },
            ),
          ],
        ),
      ),
    ),
  );
}
