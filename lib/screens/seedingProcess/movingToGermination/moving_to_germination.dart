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
    Future(() {
      Utils.hideKeyboard(context);
      ref.read(scanStateProvider.notifier).state = ScanState.idle;
    });

    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    getArgument();

    return SafeArea(child:
    Scaffold(
      appBar: getActionbar(context,context.l10n.movingToGermination),
      body:  mainWidgetForSeedingContainer(mainSeedingWidget(showScanner,toggleScanner,scanState,scanStateNotifier)),
      bottomNavigationBar:  _bottomButtonWithIconAndText(scanState,scanStateNotifier, Assets.icons.iconConfirmSave.path,"Confirm & Save"),
    ));
  }

  Widget _bottomButtonWithIconAndText(ScanState scanState, StateController<ScanState> scanStateNotifier, String path, String buttonTitle){
    return Padding(padding: EdgeInsets.all(10.w),child: CustomAddDetailButton(
      iconPath: path,
      btnName: buttonTitle,
      onPressed: () {
        // Handle move trays action
        if(scanState == ScanState.moveToFertigation){
          scanStateNotifier.state = ScanState.scanNextQR;
        }
        if(scanState == ScanState.scanNextQR){
          showTraySuccessDialog(context,false,true);
        }
      },
    )
    );
  }

  Widget _loadBottomConfirmAndScanButton(ScanState scanState, StateController<ScanState> scanStateNotifier){
    return Container(
      child: switch (scanState) {
        ScanState.idle => bottomSizeBox(),
        ScanState.scanning => bottomSizeBox(),
        ScanState.success => bottomSizeBox(),
        ScanState.confirmDetail => bottomSizeBox(),
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
        StepProgressIndicator(currentStepName: cycleStatus),
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
        ScanState.confirmDetail => loadAddingTrayContainer(context,true),
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

  // Show Confirm And Save Button
  Widget _confirmAndSaveButton (BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier){
    return Consumer(
      builder: (context, ref, _) =>  confirmAndSaveButton(context,ref,scanStateNotifier),
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