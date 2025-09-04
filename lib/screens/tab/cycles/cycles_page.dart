import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/base/utils/dashline.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:farmeasy/components/loading_list.dart';
import 'package:farmeasy/components/widget/custom_cycle_assign_person.dart';
import 'package:farmeasy/components/widget/custom_tab_cycle.dart';
import 'package:farmeasy/components/widget/searchbar_widget.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/model/model_cycle.dart';
import 'package:farmeasy/screens/tab/bottombarNavigator/provider/bottomBar_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycle_list_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycle_list_state.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../base/utils/utils.dart';
import '../../../components/widget/custom_cycle_step_progress_bar.dart';
import '../../../components/widget/custom_seeding_action_section.dart';
import '../../../components/widget/custom_steper_widget.dart';
import '../../../generated/l10n.dart';

class CyclesPage extends HookConsumerWidget {
  const CyclesPage({super.key});

  static const route = "/DashboardPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Utils.hideKeyboard(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final cycles = ref.watch(cyclesProvider);
    final cycleListState = ref.watch(cycleListProvider);
    final notifier = ref.read(cycleListProvider.notifier);

    useEffect(() {
      Future.microtask(() async {
        notifier.init();
        await notifier.apiCall();
      });
      return;
    }, const []);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBarWidget(context, onMenuTap: () {}, onSearchTap: () {}),
          CustomTabCycle(),
          Expanded(
            child: cycleListState.isApiCall ? LoadingList() : SingleChildScrollView(
              child: Column(
                children: [totalCycleWidget(context), cycleListView(cycles, cycleListState, notifier)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget cycleListView(List<ModelCycle> cycles, CycleListState cycleListState, CycleListNotifier notifier) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: cycleListState.cycleList.length,
    itemBuilder: (context, index) {
      final cycle = cycles[index];
      return Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: CycleStatusCard(cycle: cycle),
      );
    },
  );
}

Widget totalCycleWidget(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w),
    child: totalRunningCycleWidget(context),
  );
}

class CycleStatusCard extends ConsumerWidget {
  final ModelCycle cycle;
  const CycleStatusCard({super.key, required this.cycle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);
    final progress = calculateProgress(cycle);
    final progressPercentage = calculateProgressPercentage(cycle);
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.verticalSpace,
            Row(
              children: [
                Text(
                  cycle.cycleName,
                  style: AppTextStyles.robotoBodyRegular.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.cycleTrayBg,
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    cycle.trayInfo,
                    style: AppTextStyles.robotoBodyLarge.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  Assets.icons.iconArrowRight.path, // Optional: set size
                ),
              ],
            ),
            3.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Started Date • ${formatDate(cycle.startDate)}',
                  style: AppTextStyles.robotoBodyRegular.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.cycleDateTextBg,
                  ),
                ),
                Text(
                  'Est End Date • ${formatDate(cycle.startDate)}',
                  style: AppTextStyles.robotoBodyRegular.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.cycleDateTextBg,
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            StepperWidget(cycle: cycle),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  S.of(context).upcomingSeedingIn,
                  style: AppTextStyles.robotoBodyRegular.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.upComingSeedsTextBg,
                  ),
                ),
                5.horizontalSpace,
                Container(
                  decoration: AppDecorations.seedingMainBg(
                    AppColors.startSeedsMainBg,
                    AppColors.startSeedsBorderBg,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  child: Text(
                    '${cycle.arugulaTotal.toString()}${S.of(context).days}',
                    style: AppTextStyles.robotoBodyRegular.copyWith(
                      fontSize: 10.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            CustomCycleStepProgressBar(cycle: cycle),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${(progressPercentage * 100).toInt()}%",
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 10.sp,
                      color: AppColors.daysToCompleteBg,
                    ),
                  ),
                ),
                Text(
                  "14 Days",
                  style: AppTextStyles.robotoBodyLarge.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.blackColor,
                  ),
                ),
                5.horizontalSpace,
                Text(
                  S.of(context).toComplete,
                  style: AppTextStyles.robotoBodyRegular.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.daysToCompleteBg,
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            _seedingInfoContainer(cycle, context),
          ],
        ),
      ),
    );
  }

  Widget _seedingInfoContainer(ModelCycle cycle, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cycle.status,
            style: AppTextStyles.robotoBodyLarge.copyWith(
              fontSize: 14.sp,
              color: AppColors.seedingTextBg,
            ),
          ),
          5.verticalSpace,
          trayInfo(),
          5.verticalSpace,
          trayInfo(),
          5.verticalSpace,
          CustomCycleAssignPerson(onAssignTap: () {}),
          5.verticalSpace,
          DashedLine(),
          5.verticalSpace,
          currentStageCycleWidget(cycle),
          20.verticalSpace,
        ],
      ),
    );
  }
}

Widget currentStageCycleWidget(ModelCycle cycle) {
  return CustomSeedingActionSection(
    buttonText: getActionButtonText(cycle.currentStage),
    currentStage: cycle.currentStage,
    modelCycle: cycle,
  );
}

String getStageText(CycleStage stage) {
  switch (stage) {
    case CycleStage.seeding:
      return 'Seeding';
    case CycleStage.moveToGermination:
      return 'Seeding';
    case CycleStage.germination:
      return 'Moving to germination';
    case CycleStage.moveToFertigation:
      return 'Moving to Fertigation Room';
    case CycleStage.harvesting:
      return 'Moving to Harvesting';
    case CycleStage.fertigation:
      return 'Fertigation';
  }
}

Widget trayInfo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(
            '14F Trays of Arugula',
            style: AppTextStyles.robotoBodyRegular.copyWith(
              fontSize: 10.sp,
              color: AppColors.seedingTrayBg,
            ),
          ),
          4.horizontalSpace,
          SvgPicture.asset(Assets.icons.iconInfo.path),
        ],
      ),
      Text(
        '0/14 Completed',
        style: AppTextStyles.robotoBodyRegular.copyWith(
          fontSize: 10.sp,
          color: AppColors.seedingTrayBg,
        ),
      ),
    ],
  );
}

String getActionButtonText(CycleStage stage) {
  switch (stage) {
    case CycleStage.seeding:
      return 'Continue Seeding';
    case CycleStage.germination:
      return 'Start Moment';
    case CycleStage.moveToFertigation:
      return 'Start Fertigation';
    case CycleStage.harvesting:
      return 'Start Harvesting';
    case CycleStage.fertigation:
      return 'Fertigation';
    case CycleStage.moveToGermination:
      return 'Move to Germination';
  }
}

double calculateProgress(ModelCycle cycle) {
  int total = cycle.arugulaTotal + cycle.cabbageTotal;
  int completed = cycle.arugulaCompleted + cycle.cabbageCompleted;
  if (cycle.currentStage == CycleStage.seeding) {
    return 0;
  } else if (cycle.currentStage == CycleStage.moveToGermination) {
    return 0.1;
  } else {
    return 0;
  }
}

double calculateProgressPercentage(ModelCycle cycle) {
  int currentStep = cycle.seedingStatus; // example: step you reached
  int totalSteps = 8; // total process steps
  double progress = currentStep / totalSteps;
  return progress;
}
