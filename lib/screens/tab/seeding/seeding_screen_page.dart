import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/base/utils/dashline.dart';
import 'package:farmeasy/components/widget/custom_elevated_button.dart';
import 'package:farmeasy/components/widget/custom_start_seeding_btn.dart';
import 'package:farmeasy/components/widget/cycle_status_card.dart';
import 'package:farmeasy/components/widget/searchbar_widget.dart';
import 'package:farmeasy/components/widget/step_progress_widget.dart';
import 'package:farmeasy/components/widget/time_range_selection.dart';
import 'package:farmeasy/components/widget/traystatuscard.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/tab/bottombarNavigator/provider/bottomBar_provider.dart';
import 'package:farmeasy/screens/tab/seeding/provider/seeding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/scan_more_custom_button.dart';
import '../../../components/widget/custom_qr_code_scanner.dart';
import '../../../generated/l10n.dart';


class SeedingScreenPage extends ConsumerWidget {
  const SeedingScreenPage({super.key});

  static const route = "/StartSeedingPage";

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                StepProgressIndicator(currentStep: 0),
                10.verticalSpace,
                // Info card
                Container(
                  decoration: boxDecoration(AppColors.scanQrMainBg,AppColors.scanQrMainBg),
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    children: [
                      buildTopBar(),
                      SizedBox(height: 20.h),
                      Container(
                        width: double.infinity,
                        decoration: boxDecoration(AppColors.white,AppColors.white),
                        padding: EdgeInsets.all(3.r),
                        child:    Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.r),
                          decoration: AppDecorations.infoWindowBg(),
                          child: infoWindow(context),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      // QR Scan box
                     // mobileScanner(),
                     _scanQrExpand(context,showScanner,toggleScanner,scanState,scanStateNotifier),
                      SizedBox(height: 40.h),
                      Visibility(
                         visible: scanState == ScanState.idle ,
                          child:   addDetailButton(context,scanStateNotifier))
                    ],
                  ),
                ),
                // Add more widgets if needed (e.g., tray list, start button, etc.)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Add Detail button
Widget addDetailButton(BuildContext context, StateController<ScanState> scanStateNotifier){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 120.h,
        child:  ScanMoreCustomButton(btnName: context.l10n.scanMore, onPressed: (){
          scanStateNotifier.state = ScanState.scanning;
        })
      ),
      10.horizontalSpace,
      SizedBox(
        width: 120.h,
        child: CustomAddDetailButton(btnName: context.l10n.addDetail, onPressed: () {  },),
      ),
    ],);
}

// Info window Design
Widget infoWindow(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Info Icon
      SvgPicture.asset(
        Assets.icons.iconInfoBlub.path,
        width: 20.w,
        height: 20.w,
      ),
      SizedBox(width: 8.w),

      // Text Column
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelTextMedium(
              context.l10n.scanTheSeedLotCodesToStartSeedingOfTrays,
              13.sp,
              AppColors.blackColor,
            ),
            SizedBox(height: 8.h),
            labelTextMedium(
              context.l10n.youCanScanMultipleSeedLotCodesAtOnce,
              11.sp,
              AppColors.infoTextHingBg,
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerRight,
              child: labelTextBold(
                S.of(context).seeHowToDoIt,
                12.sp,
                AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
Widget mobileScanner(ScanState scanState, StateController<ScanState> scanStateNotifier){
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
             onDetect: (BarcodeCapture barcode) {
               scanStateNotifier.state = ScanState.success;
             },
           ),
         )
     ),
   )
  ;
}

Widget _scanQrExpand(BuildContext context, bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier) {
  return Center(
    child: GestureDetector(
      onTap: ()  {
        scanStateNotifier.state = ScanState.scanning;
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
              ScanState.idle =>  idealScanContainer(context,scanState,scanStateNotifier),
                ScanState.scanning => mobileScanner(scanState,scanStateNotifier),
                ScanState.success => idealScanContainer(context,scanState,scanStateNotifier),
              },
            ),
          //  idealScanContainer(context)
          ],
        ),
      ),
    ),
  );
}

Widget idealScanContainer(BuildContext context, ScanState scanState, StateController<ScanState> scanStateNotifier){
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
                ScanState.idle =>  tapScanColumn(context),
                ScanState.scanning => null,
                ScanState.success => scanSuccessWidget(context),
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget tapScanColumn(BuildContext context){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        S.of(context).tapToScan,
        style: context.textTheme.labelMedium?.copyWith(
          color: AppColors.white,
        ),
      ),
      SizedBox(height: 20.h),
      SvgPicture.asset(
        Assets.icons.iconHand.path,
        placeholderBuilder: (context) =>
        const CircularProgressIndicator(),
        fit: BoxFit.contain,
        width: 35.sp,
        height: 35.sp,
      ),
    ],
  );
}

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

      // Bottom Buttons
  ],
  );
}


Widget buildTopBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Left circular scan icon
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10.r),
        child: Icon(Icons.qr_code_scanner, size: 20.r),
      ),
      // Right icons
      Row(
        children: [
          SvgPicture.asset(Assets.icons.iconFlash.path),
          10.horizontalSpace,
          SvgPicture.asset(Assets.icons.iconMore.path),
        ],
      ),
    ],
  );
}

