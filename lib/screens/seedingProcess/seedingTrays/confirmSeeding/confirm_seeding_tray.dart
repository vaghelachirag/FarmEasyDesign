import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
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
import '../../harvestingTrays/provider/harvesting_trays_provider.dart';
import '../../../../model/seeds/addSeedRequestJson/add_seed_request_json.dart';
import '../../../../network/authRepositoryProvider.dart';
import '../addPersonDetail/provider/add_person_detail_screen_provider.dart';


class ConfirmSeedingTray extends ConsumerStatefulWidget {
  late CycleStage cycleStatus;

  ConfirmSeedingTray({super.key});


  @override
  ConsumerState<ConfirmSeedingTray> createState() => _ConfirmSeedingTray();
}

class _ConfirmSeedingTray extends ConsumerState<ConfirmSeedingTray>
    with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    //  Utils.hideKeyboard(context);
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

    final List<String> seedLotCodes = ["#4577", "#4580", "#4599", "#4601","#4601","#4601","#4601","#4601"];

    return SafeArea(child: Scaffold(
      appBar: getActionbar(context,S.of(context).harvestingTrays),
      body:  SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    Row(
                      children: [
                        Text('Seeding 30 Trays :',style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 12.sp)),
                        4.horizontalSpace,
                        Text('11 Full Trays | 19 Half Trays',style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 12.sp)),
                      ],
                    ),
                    8.verticalSpace,
                    Text('Seed Lot Code: ',style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 12.sp)),
                    5.verticalSpace,
                    seedLotCodeList(seedLotCodes),
                    8.verticalSpace,
                    trayTextWidget("Tray Details:","8 Arugula Tray | 9 Gms ",context),
                    8.verticalSpace,
                    trayTextWidget("Coir Weight :","9 Gms ",context),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        trayTextWidget(S.of(context).currentStatus,S.of(context).seeding,context),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.trayInfoPopupBg,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(S.of(context).updateToday,style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.blackColor))
                        )
                      ],
                    )
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
                    btnName: S.of(context).confirmProceed,
                    onPressed: () async {
                      final scannedLots = ref.read(scannedSeedLotsProvider);
                      if (scannedLots.isEmpty) {
                        Utils.showSnackBar(context, 'Scan at least one seed lot');
                        return;
                      }
                      // TODO: Wire these inputs from previous screen or state
                      final request = AddSeedRequest(
                        seedLots: scannedLots.map((e) => AddSeedLotRequestData(seedLotId: e.id, quantityKg: int.tryParse(e.currentQuantityKg) ?? 0)).toList(),
                        seedGramsPerTray: 0,
                        coirGramsPerTray: 0,
                        numFullTrays: 0,
                        numHalfTrays: 0,
                      );

                      final repo = ref.read(authRepositoryProvider);
                      final ok = await repo.addSeeds(request);
                      if (ok) {
                        Utils.showSnackBar(context, 'Seeds added successfully');
                        context.navigator.pushNamed(homeTab);
                      } else {
                        Utils.showSnackBar(context, 'Failed to add seeds', color: Colors.red);
                      }
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
