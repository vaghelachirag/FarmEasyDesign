import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/utils/app_colors.dart';
import '../../../../base/utils/app_decorations.dart';
import '../../../../base/utils/common_widgets.dart';
import '../../../../base/utils/constants.dart';
import '../../../../base/utils/custom_add_detail_button.dart';
import '../../../../base/utils/dialougs.dart';
import '../../../../base/utils/utils.dart';
import '../../../../components/widget/step_progress_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../generator/assets.gen.dart';
import '../../../tab/cycles/provider/cycles_provider.dart';
import '../../../tab/seeding/provider/seeding_provider.dart';
import '../provider/harvesting_trays_provider.dart';

class ConfirmHarvestingTrayDetail extends ConsumerStatefulWidget {
  static const route = "/ConfirmHarvestingTrayDetail";


  late CycleStage cycleStatus;

  ConfirmHarvestingTrayDetail({super.key});


  @override
  ConsumerState<ConfirmHarvestingTrayDetail> createState() => _ConfirmHarvestingTrayDetail();
}

class _ConfirmHarvestingTrayDetail extends ConsumerState<ConfirmHarvestingTrayDetail>
    with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    Utils.hideKeyboard(context);
  }

  @override
  Widget build(BuildContext context) {

    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    final isVisibleAddDetail = ref.watch(isHarvestDueProvider);
    final addDetailStateNotifier = ref.read(isHarvestDueProvider.notifier);

    getArgument();

    return SafeArea(child: Scaffold(
      appBar: getActionbar(context,S.of(context).harvestingTrays),
      body:  SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              StepProgressIndicator(currentStepName: widget.cycleStatus,),
              10.verticalSpace,
              Container(
                width: double.infinity,
                decoration: AppDecorations.moveToGerminationDialogueDecoration(),
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.images.harvestingSucess.path),
                    10.verticalSpace,
                    Text('Harvesting 8 Trays :',style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
                    8.verticalSpace,
                    trayTextWidget("Tray Details:","8 Arugula Tray | 9 Gms ",context),
                    8.verticalSpace,
                    trayTextWidget("Tray Position: ","Zone 3 | Section 4 | Level 3 ",context),
                    trayTextWidget("Tray Position: ","Zone 3 | Section 4 | Level 3 ",context),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        trayTextWidget(S.of(context).currentStatus,S.of(context).harvest,context),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.trayInfoPopupBg,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(S.of(context).updateToday,style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.blackColor))
                        )
                      ],
                    ),
                    trayTextWidget(S.of(context).harvestedQty,"90 Gms",context),
                  ],
                ),
              ),
              20.verticalSpace,
              // Confirm Button
              SizedBox(
                  width: double.infinity,
                  child:
                  CustomAddDetailButton(
                    iconPath: Assets.icons.iconConfirmAndProcessed.path,
                    btnName: "Confirm & Proceed",
                    onPressed: () {
                    },
                  ))
            ],
          ),
        ),
      ),
    ));
  }

  void getArgument() {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    widget.cycleStatus = args[cycleStageArgumentName];
  }

}
