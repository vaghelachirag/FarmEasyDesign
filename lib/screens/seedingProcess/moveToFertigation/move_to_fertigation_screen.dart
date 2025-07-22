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
import 'package:farmeasy/base/utils/common_widgets.dart';

import '../../../base/utils/constants.dart';
import '../../../base/utils/custom_add_detail_button.dart';
import '../../../base/utils/scan_more_custom_button.dart';
import '../../../components/widget/step_progress_widget.dart';
import '../../../generator/assets.gen.dart';
import '../../tab/seeding/provider/seeding_provider.dart';
import '../seedingTrays/addPersonDetail/add_person_detail_screen.dart';

class MoveToFertigationScreen extends ConsumerStatefulWidget {
  static const route = "/MoveToFertigationScreen";

  const MoveToFertigationScreen({super.key});

  @override
  ConsumerState<MoveToFertigationScreen> createState() => _MoveToFertigationScreen();
}

class _MoveToFertigationScreen extends ConsumerState<MoveToFertigationScreen>
    with TickerProviderStateMixin {

  late CycleStage cycleStatus;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    getArgument();


    return SafeArea(child: Scaffold(
      appBar: getActionbar("Move to Fertigation"),
      body:  SizedBox(
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
          //_showActionRequiredSection(scanState),
          _nextActionButton(context,ref,scanStateNotifier)
        ],
      ),
    );
  }

  // Show Next Action Button
  Widget _nextActionButton (BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier){
    return Consumer(
      builder: (context, ref, _) =>  nextActionButton(context,ref,scanStateNotifier),
    );
  }


  // Add Detail button
  Widget nextActionButton(BuildContext context, WidgetRef ref, StateController<ScanState> scanStateNotifier){
    final scanState = ref.watch(scanStateProvider);
    return scanState == ScanState.scanning?  Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 100.w,
        child: CustomAddDetailButton(btnName: "Next", onPressed: () {
          context.navigator.pushNamed(
            AddPersonDetailScreen.route,
            arguments: {cycleStageArgumentName: cycleStatus},
          );
        },iconPath: Assets.icons.iconNext.path),
      ),
    )  : Container();
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