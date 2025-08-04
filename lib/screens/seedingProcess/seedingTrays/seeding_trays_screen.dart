import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/screens/seedingProcess/seedingTrays/addPersonDetail/add_person_detail_screen.dart';
import 'package:farmeasy/screens/splash/provider/splash_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../base/utils/constants.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/scan_more_custom_button.dart';
import '../../../base/utils/utils.dart';
import '../../../components/widget/step_progress_widget.dart';
import '../../../generated/l10n.dart';
import '../../../generator/assets.gen.dart';
import '../../tab/bottombarNavigator/provider/bottomBar_provider.dart';
import '../../tab/seeding/provider/seeding_provider.dart';

class SeedingTraysScreen extends ConsumerStatefulWidget {
  static const route = "/SeedingTraysScreen";

  const SeedingTraysScreen({super.key});

  @override
  ConsumerState<SeedingTraysScreen> createState() => _SeedingTraysScreen();
}

class _SeedingTraysScreen extends ConsumerState<SeedingTraysScreen>
    with TickerProviderStateMixin {

  late CycleStage cycleStatus;


  @override
  void initState() {
    super.initState();
    Future(() {
      Utils.hideKeyboard(context);
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

    return SafeArea(child: Scaffold(
      appBar: getActionbar(context,S.of(context).seedingTrays),
      body:  mainWidgetForSeedingContainer(mainSeedingWidget(showScanner,toggleScanner,scanState,scanStateNotifier))
    ));
  }

  // Main Widget for Load Seeding page
  Widget mainSeedingWidget(bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepProgressIndicator(currentStepName: cycleStatus),
        10.verticalSpace,
        _loadMainWidget(showScanner,toggleScanner,scanState,scanStateNotifier),
      ],
    );
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
          20.verticalSpace,
          _confirmAndSaveButton(context,ref,scanStateNotifier)
        ],
      ),
    );
  }

  // Show Confirm And Save Button
  Widget _confirmAndSaveButton (BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier){
    return Consumer(
      builder: (context, ref, _) =>  confirmAndSaveButton(context,ref,scanStateNotifier),
    );
  }

  // Add Detail button
  Widget confirmAndSaveButton(BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier){
    final scanState = ref.watch(scanStateProvider);
    return scanState == ScanState.success?  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 120.h,
            child:  ScanMoreCustomButton(btnName: context.l10n.scanMore, onPressed: (){
              scanStateNotifier.state =  ScanState.scanning;
            })
        ),
        10.horizontalSpace,
        SizedBox(
          width: 120.h,
          child: CustomAddDetailButton(btnName: context.l10n.addDetail, onPressed: () {
            context.navigator.pushNamed(
              AddPersonDetailScreen.route,
              arguments: {cycleStageArgumentName: cycleStatus},
            );
          },iconPath: Assets.icons.iconAddDetail.path),
        ),
      ],) : Container();
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