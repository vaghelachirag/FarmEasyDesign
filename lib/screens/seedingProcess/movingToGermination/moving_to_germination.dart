import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/screens/splash/provider/splash_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart' hide infoWindow;

import '../../../base/utils/constants.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/dialougs.dart';
import '../../../base/utils/scan_more_custom_button.dart';
import '../../../components/widget/step_progress_widget.dart';
import '../../../generator/assets.gen.dart';
import '../../tab/bottombarNavigator/provider/bottomBar_provider.dart';
import '../../tab/seeding/addDetail/add_seeding_screen.dart';
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
    final cycles = ref.watch(cyclesProvider);


    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    getArgument();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return SafeArea(child: Scaffold(
      appBar: getActionbar("Moving to germination"),
      body:   SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            StepProgressIndicator(currentStepName: cycleStatus),
            10.verticalSpace,
            Container(
              decoration: boxDecoration(AppColors.scanQrMainBg,AppColors.scanQrMainBg),
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: [
                  buildTopBar(),
                  SizedBox(height: 20.h),
                  Consumer(
                    builder: (context, ref, _) => infoWidowForScan(context, cycleStatus,ref),
                  ),
                  SizedBox(height: 40.h),
                  scanQrExpand(context,showScanner,toggleScanner,scanState,scanStateNotifier,cycleStatus),
                  SizedBox(height: 40.h),
                  Visibility(
                      visible: scanState == ScanState.success ,
                      child:   showActionRequiredSection()),
                ],
              ),
            ),
            20.verticalSpace,
            Consumer(
              builder: (context, ref, _) =>  confirmAndSaveButton(context,ref),
            ),

          ],
        ),
      ),
    ),
    ));
  }

  void getArgument() {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cycleStatus = args[cycleStageArgumentName];
  }
}

Widget showActionRequiredSection(){
  return  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelTextMedium('Action Required', 16.sp, AppColors.blackColor),
          6.verticalSpace,
          Row(
            children: [
              Expanded(
                child:
                labelTextRegular( 'You are trying to add trays beyond the available tray space on the scanned level.', 12.sp, AppColors.navBarUnselectedColor)
              ),
              SvgPicture.asset(Assets.icons.iconInfo.path)
            ],
          ),
          SizedBox(height: 12),
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
                        TextSpan(text: 'This Level has only '),
                        TextSpan(
                          text: '5 available',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' Tray space. You can Confirm this position for first '),
                        TextSpan(
                          text: '5',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' scanned Trays and scan a new level QR for remaining '),
                        TextSpan(
                          text: '3 Trays.',
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


// Add Detail button
Widget confirmAndSaveButton(BuildContext context, WidgetRef ref){
  final scanState = ref.watch(scanStateProvider);
  return scanState == ScanState.success ? SizedBox(
    width: double.infinity,
    child: CustomAddDetailButton(
      iconPath: Assets.icons.iconScanNow.path,
      btnName: "Confirm & Scan next Level QR",
      onPressed: () {
        showTraySuccessDialog(context);
      },
    ),
  ) : Container();
}