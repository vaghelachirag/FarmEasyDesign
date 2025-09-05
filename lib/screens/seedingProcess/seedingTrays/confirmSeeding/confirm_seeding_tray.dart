import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../base/utils/app_colors.dart';
import '../../../../base/utils/app_decorations.dart';
import '../../../../base/utils/common_widgets.dart';
import '../../../../base/utils/constants.dart';
import '../../../../base/utils/custom_add_detail_button.dart';
import '../../../../base/utils/dialougs.dart';
import '../../../../base/utils/utils.dart';
import '../../../../components/widget/step_progress_widget.dart';
import '../../../../components/widget/custom_input_field.dart';
import '../../../../generated/l10n.dart';
import '../../../../generator/assets.gen.dart';
import '../../../tab/cycles/provider/cycles_provider.dart';
import '../../../tab/seeding/provider/seeding_provider.dart';
import '../../harvestingTrays/provider/harvesting_trays_provider.dart';
import '../../../../model/seeds/addSeedRequestJson/add_seed_request_json.dart';
import '../../../../network/authRepositoryProvider.dart';
import '../addPersonDetail/provider/add_person_detail_screen_provider.dart';


class ConfirmSeedingTray extends HookConsumerWidget {
  late CycleStage cycleStatus;
  late String seedLotCode;
  late String numberOfFullTrays;
  late String numberOfHalfTrays;
  late String seedsName;
  late String seedWeightTray;
  late String coreWeightTray;
  late String seedingDate;
  late int totalTray;

  ConfirmSeedingTray({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get arguments first
    getArgument(context);


    // Build seed lot chips from scanned seed lots
    final scannedSeedLots = ref.watch(scannedSeedLotsProvider);
    final List<String> seedLotCodes = scannedSeedLots
        .map((e) => e.lotCode.startsWith('#') ? e.lotCode : '#${e.lotCode}')
        .toList();

    final List<String> seedLotList = scannedSeedLots
        .map((e) => e.id)
        .toList();

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
              StepProgressIndicator(currentStepName: cycleStatus,),
              10.verticalSpace,
              // Display the passed data in text fields
              Container(
                width: double.infinity,
                decoration: AppDecorations.moveToGerminationDialogueDecoration(),
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.images.harvestingSucess.path),
                    20.verticalSpace,
                    Row(
                      children: [
                        Text('Seeding $totalTray Trays :',style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 12.sp)),
                        4.horizontalSpace,
                        Text('$numberOfFullTrays  Full Trays | $numberOfHalfTrays Half Trays',style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 12.sp)),
                      ],
                    ),
                    8.verticalSpace,
                    Text('Seed Lot Code: ',style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 12.sp)),
                    5.verticalSpace,
                    seedLotCodeList(seedLotCodes),
                    8.verticalSpace,
                    trayTextWidget("Tray Details:","8 Arugula Tray | 9 Gms ",context),
                    8.verticalSpace,
                    trayTextWidget("Coir Weight :",numberOfFullTrays,context),
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

                      final jsonData = {
                        "seedLots": seedLotList,
                        "seedGramsPerTray": int.tryParse(seedWeightTray.toString()) ?? 0,
                        "coirGramsPerTray": int.tryParse(coreWeightTray.toString()) ?? 0,
                        "numFullTrays": int.tryParse(numberOfFullTrays.toString()) ?? 0,
                        "numHalfTrays": int.tryParse(numberOfHalfTrays.toString()) ?? 0
                      };

                      final addSeedRequestJson = AddSeedRequestJson.fromJson(jsonData);

                      final repo = ref.read(authRepositoryProvider);
                      final ok = await repo.addSeeds(addSeedRequestJson);
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

  void getArgument(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cycleStatus = args[cycleStageArgumentName];
    seedLotCode = args['seedLotCode'] ?? '';
    numberOfFullTrays = args['numberOfFullTrays'] ?? '';
    numberOfHalfTrays = args['numberOfHalfTrays'] ?? '';
    seedsName = args['seedsName'] ?? '';
    seedWeightTray = args['seedWeightTray'] ?? '';
    coreWeightTray = args['coreWeightTray'] ?? '';
    seedingDate = args['seedingDate'] ?? '';

    totalTray = int.tryParse(args['numberOfFullTrays']?.toString() ?? '0')! +  int.tryParse(args['numberOfHalfTrays']?.toString() ?? '0')!;
  }
}
