
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
import '../../../components/widget/widget_custom_qr_processed.dart';
import '../../../generated/l10n.dart';
import '../../../generator/assets.gen.dart';
import '../../seedingProcess/harvestingTrays/assignHarvestingTray/assign_harvesting_tray.dart';
import '../../seedingProcess/seedingTrays/addPersonDetail/provider/add_person_detail_screen_provider.dart';
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
    return (scanState == MoveTrayScanState.confirmAndScan ||
        scanState == MoveTrayScanState.addDetail)
        ? loadAddDetailWidget(context,scanStateNotifier) :  Container(
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
                MoveTrayScanState.scanLevelQR => scanSuccessWidget(context),
                MoveTrayScanState.addDetail => idealScanContainerMoveTray(context,scanState,scanStateNotifier,ref),
                MoveTrayScanState.confirmAndScan => idealScanContainerMoveTray(context,scanState,scanStateNotifier,ref),
                MoveTrayScanState.scanMore => idealScanContainerMoveTray(context,scanState,scanStateNotifier,ref),
                MoveTrayScanState.actionRequired => idealScanContainerMoveTray(context,scanState,scanStateNotifier,ref),
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
                MoveTrayScanState.scanning => mobileScannerMoveTray(scanState, scanStateNotifier,ref),
                MoveTrayScanState.scanLevelQR => scanSuccessWidget(context),
                MoveTrayScanState.addDetail => loadAddDetailWidget(context,scanStateNotifier),
                MoveTrayScanState.confirmAndScan =>   tapScanColumn(context),
                MoveTrayScanState.scanMore => tapScanColumn(context),
                MoveTrayScanState.actionRequired => scanSuccessWidget(context),
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
                scanStateNotifier.state = MoveTrayScanState.scanLevelQR;
              },
            ),
          )
      ),
    )
  ;
}
// Add Detail button
Widget confirmAndSaveButton(
    BuildContext context,
    WidgetRef ref,
    StateController<MoveTrayScanState> scanStateNotifier) {
  final scanState = ref.watch(moveTrayScanStateProvider);

  return (scanState == MoveTrayScanState.scanLevelQR)
      ? Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        width: 140.w,
        child: CustomAddDetailButton( btnName: "Next", onPressed: () {
          if (scanStateNotifier.state == MoveTrayScanState.scanLevelQR) {
            scanStateNotifier.state = MoveTrayScanState.addDetail;
          }else{
            scanStateNotifier.state = MoveTrayScanState.actionRequired;
          }
        },iconPath: Assets.icons.iconNext.path),
      ),
    ],
  )
      : Container();
}

Widget loadAddDetailWidget(BuildContext context, StateController<MoveTrayScanState> scanStateNotifier){
  return Container(
    decoration: boxDecoration(AppColors.scanQrMainBg, AppColors.scanQrMainBg),
    padding: EdgeInsets.all(16.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with edit and more options
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Edit button
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                color: Colors.grey[600],
                size: 20.sp,
              ),
            ),
            // More options
            Icon(
              Icons.more_vert,
              color: AppColors.white,
              size: 24.sp,
            ),
          ],
        ),
        20.verticalSpace,
        
        // Number of Full Trays
        _buildInputField(
          title: "Number of Full Trays",
          controller: TextEditingController(),
          inputType: TextInputType.number,
        ),
        20.verticalSpace,
        
        // Number of Half Trays
        _buildInputField(
          title: "Number of Half Trays",
          controller: TextEditingController(),
          inputType: TextInputType.number,
        ),
        20.verticalSpace,
        
        // Seed Name
        _buildInputField(
          title: "Seed Name",
          controller: TextEditingController(text: "Alugura"),
          inputType: TextInputType.text,
        ),
        20.verticalSpace,
        
        // Assigned People
        _buildAssignedPeopleField(),
        20.verticalSpace,

        _buildDateField(),
        20.verticalSpace,
        _buildReasonField(),
        40.verticalSpace,
        _customProcessButton(context,scanStateNotifier)
      ],
    ),
  );
}

Widget _buildInputField({
  required String title,
  required TextEditingController controller,
  required TextInputType inputType,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.green[300],
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      8.verticalSpace,
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}

Widget _buildAssignedPeopleField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Assigned People",
        style: TextStyle(
          color: Colors.green[300],
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      8.verticalSpace,
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 16.sp,
              backgroundImage: AssetImage('assets/images/assign_person_1.png'),
            ),
            8.horizontalSpace,
            // Name
            Text(
              "Navin A",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14.sp,
              ),
            ),
            Spacer(),
            // Remove button
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.green[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.grey[800],
                size: 16.sp,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildDateField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Seeding Date",
        style: TextStyle(
          color: Colors.green[300],
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      8.verticalSpace,
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  "25/05/2025",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            // Calendar icon
            Container(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.calendar_today,
                color: Colors.green[300],
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildReasonField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Reason for Movement",
        style: TextStyle(
          color: Colors.green[300],
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      8.verticalSpace,
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: TextEditingController(text: "The nutrients were not enough"),
          maxLines: 3,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}


Widget _customProcessButton(BuildContext context, StateController<MoveTrayScanState> scanStateNotifier){
  return CustomProceedButton(
      onPressed: (){
        scanStateNotifier.state = MoveTrayScanState.scanMore;
      },
      title: S.of(context).processed,
      iconPath: Assets.icons.iconQrProcessed.path
  );
}