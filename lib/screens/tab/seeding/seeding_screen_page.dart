import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
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
import '../../../base/utils/utils.dart';
import '../../../components/widget/step_progress_widget.dart';
import '../../../generated/l10n.dart';
import '../../../base/utils/common_widgets.dart';


class SeedingScreenPage extends ConsumerWidget {
  const SeedingScreenPage({super.key});

  static const route = "/SeedingScreenPage";



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Utils.hideKeyboard(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);


    return SafeArea(
      child: Scaffold(
        appBar: getActionbar(context,S.of(context).seedingTrays),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
              //  StepProgressIndicator(currentStep: 0),
                10.verticalSpace,
                // Info card
                Container(
                  decoration: boxDecoration(AppColors.scanQrMainBg,AppColors.scanQrMainBg),
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    children: [
                      buildTopBar(),
                      SizedBox(height: 20.h),
                      SizedBox(height: 40.h),
                      // QR Scan box
                     // mobileScanner(),
                     // scanQrExpand(context,showScanner,toggleScanner,scanState,scanStateNotifier,c),
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
        child: CustomAddDetailButton(
          iconPath: Assets.icons.iconAddDetail.path,
          btnName: context.l10n.addDetail, onPressed: () {  },),
      ),
    ],);
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