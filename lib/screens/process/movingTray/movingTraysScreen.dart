import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/screens/process/movingTray/provider/moving_tray_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/base/utils/common_widgets.dart' hide infoWindow;
import '../../../base/utils/app_decorations.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/dialougs.dart';
import '../../../generator/assets.gen.dart';
import '../../seedingProcess/harvestingTrays/assignHarvestingTray/assign_harvesting_tray.dart';
import '../../seedingProcess/seedingTrays/addPersonDetail/provider/add_person_detail_screen_provider.dart';
import '../../tab/seeding/provider/seeding_provider.dart';
import '../stepProcess/stepConfigMovingTray.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../components/widget/step_progress_widget.dart';

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
      ref.read(moveTrayScanStateProvider.notifier).state = MoveTrayScanState.idle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final showScanner = ref.watch(moveTrayScanToggleProvider);
    final toggleScanner = ref.read(moveTrayScanToggleProvider.notifier);
    final scanState = ref.watch(moveTrayScanStateProvider);
    final scanStateNotifier = ref.read(moveTrayScanStateProvider.notifier);

    getArgument();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: getActionbar(context, 'Moving Trays'),
        body: mainWidgetForSeedingContainer(
          _mainMovingWidget(showScanner, toggleScanner, scanState, scanStateNotifier, ref),
        ),
      ),
    );
  }

  // Top section matching seeding screen structure
  Widget _mainMovingWidget(bool showScanner, StateController<bool> toggleScanner, MoveTrayScanState scanState, StateController<MoveTrayScanState> scanStateNotifier, WidgetRef ref){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepProgressIndicator(currentStepName: cycleStatus),
        10.verticalSpace,
        _loadMainWidget(showScanner, toggleScanner, scanState, scanStateNotifier, ref),
      ],
    );
  }

  Widget _loadMainWidget(bool showScanner, StateController<bool> toggleScanner, MoveTrayScanState scanState, StateController<MoveTrayScanState> scanStateNotifier, WidgetRef ref){
    return Container(
      decoration: boxDecoration(AppColors.scanQrMainBg, AppColors.scanQrMainBg),
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          buildTopBar(),
          20.verticalSpace,
          _loadInfoWidow(),
          40.verticalSpace,
          scanQrExpandMoveTray(context, showScanner, toggleScanner, scanState, scanStateNotifier, cycleStatus, ref),
          40.verticalSpace,
          20.verticalSpace,
          _confirmAndSaveButton(context, ref, scanStateNotifier),
        ],
      ),
    );
  }

  Widget _loadInfoWidow(){
    return Consumer(
      builder: (context, ref, _) => infoWidowForScan(context, cycleStatus, ref),
    );
  }

  Widget _confirmAndSaveButton(BuildContext context, WidgetRef ref, StateController<MoveTrayScanState> scanStateNotifier){
    return Consumer(
      builder: (context, ref, _) => confirmAndSaveButton(context, ref, scanStateNotifier),
    );
  }

  void getArgument() {
  /*  final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cycleStatus = args[cycleStageArgumentName];*/
    cycleStatus = CycleStage.moveToFertigation;
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


Widget scanQrExpandMoveTray(BuildContext context, bool showScanner, StateController<bool> toggleScanner, MoveTrayScanState scanState, StateController<MoveTrayScanState> scanStateNotifier, CycleStage cycleStatus, WidgetRef ref) {
  return Center(
    child: GestureDetector(
      onTap: ()  {
        // scanStateNotifier.state = ScanState.scanning;
        scanStateNotifier.state = MoveTrayScanState.scanning;
      },
      child: SizedBox(
        height: 240.h,
        width: 240.w,
        child:
        Stack(
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
              child: switch(scanState){
                MoveTrayScanState.idle => idealScanContainerMoveTray(context,scanState,scanStateNotifier,ref),
                MoveTrayScanState.scanning => mobileScannerMoveTray(scanState,scanStateNotifier,ref),
                MoveTrayScanState.scanLevelQR =>Text("Test"),
                // TODO: Handle this case.
                MoveTrayScanState.addDetail => Text("Test"),
                // TODO: Handle this case.
                MoveTrayScanState.confirmAndScan => Text("Test"),
              },
            ),
            //  idealScanContainer(context)
          ],
        ),
      ),
    ),
  );
}

Widget idealScanContainerMoveTray(BuildContext context, MoveTrayScanState scanState, StateController<MoveTrayScanState> scanStateNotifier, WidgetRef ref){
  return Container(
    margin: EdgeInsets.all(15),
    decoration: AppDecorations.scanQrcodeBg(),
    child:   Padding(
      padding: EdgeInsets.all(20.r), // Add internal spacing
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
                MoveTrayScanState.idle => tapScanColumn(context),
                // TODO: Handle this case.
                MoveTrayScanState.scanning => scanSuccessWidget(context),
                // TODO: Handle this case.
                MoveTrayScanState.scanLevelQR => tapScanColumn(context),
                // TODO: Handle this case.
                MoveTrayScanState.addDetail => Text("Add Detail"),
                // TODO: Handle this case.
                MoveTrayScanState.confirmAndScan =>  Text("Add Detail"),
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget mobileScannerMoveTray(MoveTrayScanState scanState, StateController<MoveTrayScanState> scanStateNotifier, WidgetRef ref){
  final scannedSeeds = ref.watch(scannedSeedLotsProvider);
  return
    Center(
      child:  Container(
          margin: EdgeInsets.all(15),
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.normal,
                facing: CameraFacing.back,
              ),
              onDetect: (barcodeCapture) {
                if(scanState == MoveTrayScanState.scanLevelQR){
                  scanStateNotifier.state = MoveTrayScanState.addDetail;
                }else{
                  scanStateNotifier.state = MoveTrayScanState.confirmAndScan;
                }
              },
            ),
          )
      ),
    )
  ;
}


// Add Detail button
Widget confirmAndSaveButton(BuildContext context, WidgetRef ref, StateController<MoveTrayScanState> scanStateNotifier){
  final scanState = ref.watch(scanStateProvider);
  if (scanState == ScanState.idle) return const SizedBox.shrink();

  String buttonLabel;
  VoidCallback onPressed;

  if (scanState == ScanState.success) {
    // After first scan success -> go to Add Details (Step 2)
    buttonLabel = context.l10n.next;
    onPressed = () {
      scanStateNotifier.state = MoveTrayScanState.addDetail;
    };
  } else if (scanState == ScanState.confirmDetail) {
    // After confirming details -> move to step 3 to scan next level
    buttonLabel = context.l10n.next;
    onPressed = () {
      const stepsLength = 3;
      final controller = ref.read(stepControllerProvider(stepsLength).notifier);
      controller.completeAndNext();
    //  scanStateNotifier.state = ScanState.moveToFertigation;
    };
  } else if (scanState == ScanState.scanNextQR) {
    // Second scan success -> Confirm & Save
    buttonLabel = context.l10n.confirmScanNextLevelQr;
    onPressed = () {
      showTraySuccessDialog(context,false,false);
    };
  } else {
    return const SizedBox.shrink();
  }

  return SizedBox(
    width: double.infinity,
    child: CustomAddDetailButton(
      iconPath: Assets.icons.iconScanNow.path,
      btnName: buttonLabel,
      onPressed: onPressed,
    ),
  ) ;
}
