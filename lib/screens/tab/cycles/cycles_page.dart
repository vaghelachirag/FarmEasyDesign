import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/base/utils/dashline.dart';
import 'package:farmeasy/components/widget/custom_cycle_assign_person.dart';
import 'package:farmeasy/components/widget/custom_tab_cycle.dart';
import 'package:farmeasy/components/widget/searchbar_widget.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/model/model_cycle.dart';
import 'package:farmeasy/screens/tab/bottombarNavigator/provider/bottomBar_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../components/widget/custom_cycle_step_progress_bar.dart';
import '../../../components/widget/custom_seeding_action_section.dart';
import '../../../components/widget/custom_steper_widget.dart';

class CyclesPage extends ConsumerWidget {
  const CyclesPage({super.key});

  static const route = "/DashboardPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final cycles = ref.watch(cyclesProvider);

    return SafeArea(child:
    Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
              context,
              onMenuTap: () {
              },
              onSearchTap: () {
              },
            ),
            CustomTabCycle(),
            totalCycleWidget(context),
            cycleListView(cycles)
          ],
        ),
      ),
    ));
  }
}

Widget cycleListView(List<ModelCycle> cycles){
return   ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: cycles.length,itemBuilder: (context, index){
  final cycle = cycles[index];
  return Padding(padding: EdgeInsets.only(left: 16.w,right: 16.w),child: CycleStatusCard(cycle: cycle),) ;
},);
}

Widget totalCycleWidget(BuildContext context){
  return  Padding(padding: EdgeInsets.only(left: 20.w,right: 20.w),child: totalRunningCycleWidget(context));
}

class CycleStatusCard extends ConsumerWidget {
  final ModelCycle cycle;
  const CycleStatusCard({super.key, required this.cycle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);
    final progress = calculateProgress(cycle);
    return  Card(
      child: Container(
        padding: EdgeInsets.only(left: 16.sp,right: 16.sp),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Row(
              children: [
                // Left text
                labelTextBold("Cycle 8", 16.sp, AppColors.blackColor),
                SizedBox(width: 8.w),
                // Middle text with flexible width
                Expanded(
                  child: labelTextRegular(
                    "• 38 Arugula Trays",
                    14.sp,
                    AppColors.cycleTrayBg,
                  ),
                ),
                SvgPicture.asset(
                  Assets.icons.iconArrowRight.path// Optional: set size
                ),
              ],
            ),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelTextMedium('Started Date • ${formatDate(cycle.startDate)}', 10.sp, AppColors.cycleDateTextBg),
                labelTextMedium('Est End Date • ${formatDate(cycle.startDate)}', 10.sp, AppColors.cycleDateTextBg),
              ],
            ),
            10.verticalSpace,
            StepperWidget(cycle: cycle),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                labelTextRegular("Upcoming Seeding in", 10.sp, AppColors.upComingSeedsTextBg),
                5.horizontalSpace,
                Container(
                  decoration: AppDecorations.seedingMainBg(),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  child:   labelTextMedium("${cycle.arugulaTotal.toString()} Days", 10.sp, AppColors.blackColor)
                ),
              ],
            ),
            10.verticalSpace,
            CustomCycleStepProgressBar(cycle: cycle),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child:
                labelTextBold('${(0 * 100).toInt()}%', 12.sp, AppColors.daysToCompleteBg)),
                labelTextBold("14 Days", 14.sp, AppColors.blackColor),
                5.horizontalSpace,
                labelTextRegular("to Complete", 10.sp, AppColors.daysToCompleteBg)
              ],
            ),
            10.verticalSpace,
            _seedingInfoContainer(cycle)
          ],
        ),
      ),
    );
  }


  Widget _seedingInfoContainer(ModelCycle cycle){
    return Container(
      padding: EdgeInsets.only(left: 5.w,right: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelTextRegular(cycle.status, 16.sp, AppColors.seedingTextBg),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  labelTextMedium('14F Trays of Arugula', 10.sp, AppColors.seedingTrayBg),
                  4.horizontalSpace,
                  SvgPicture.asset(Assets.icons.iconInfo.path)
                ],
              ),
              labelTextMedium('0/14 Completed', 10.sp, AppColors.seedingTrayBg),
            ],
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  labelTextMedium('14F Trays of Arugula', 10.sp, AppColors.seedingTrayBg),
                  const SizedBox(width: 4),
                  SvgPicture.asset(Assets.icons.iconInfo.path)
                ],
              ),
              labelTextMedium('0/14 Completed', 10.sp, AppColors.seedingTrayBg),
            ],
          ),
          5.verticalSpace,
          CustomCycleAssignPerson(
            onAssignTap: () {
              // Show modal, navigate, etc.
            },
          ),
          5.verticalSpace,
          DashedLine(),
          5.verticalSpace,
          CustomSeedingActionSection(buttonText: getActionButtonText(cycle.currentStage),),
          20.verticalSpace,
        ],
      ),
    );
  }
}


class SeedingButtonsRow extends StatelessWidget {
  const SeedingButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100.w,child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1C7C45), // Green
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24), // pill shape
            ),
            minimumSize: const Size(80, 40), // width, height
            padding: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
          ),
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.icons.iconSeeds.path,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          label: labelTextMedium("Start Seeding", 12.sp, AppColors.white),
        ),),
        const SizedBox(width: 12),
        SizedBox(width: 50.w,child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFE7F5E9), // light green
              foregroundColor: const Color(0xFF1C7C45), // dark green icon/text
              side: BorderSide(color: Colors.green.shade200),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              minimumSize: const Size(140, 40),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onPressed: () {},
            icon: SvgPicture.asset(
              Assets.icons.iconMarkIssue.path,
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(Color(0xFF1C7C45), BlendMode.srcIn),
            ),
            label: labelTextMedium("Mark Issue", 12.sp, AppColors.totalAssignPersonTextBg)
        ),),
      ],
    );
  }
}

String getStageText(CycleStage stage) {
  switch (stage) {
    case CycleStage.movement:
      return 'Moving to germination';
    case CycleStage.germination:
      return 'Germination in progress';
    case CycleStage.seeding:
      return 'Seeding';
    case CycleStage.fertigation:
      return 'Fertigation';
    case CycleStage.harvesting:
      return 'Harvesting';
  }
}

String getActionButtonText(CycleStage stage) {
  switch (stage) {
    case CycleStage.movement:
      return 'Start movement';
    case CycleStage.germination:
    case CycleStage.seeding:
      return 'Start Seeding';
    case CycleStage.fertigation:
      return 'Start Fertigation';
    case CycleStage.harvesting:
      return 'Start Harvesting';
  }
}

double calculateProgress(ModelCycle cycle) {
  int total = cycle.arugulaTotal + cycle.cabbageTotal;
  int completed = cycle.arugulaCompleted + cycle.cabbageCompleted;
  if (total == 0) return 0;
  return completed / total;
}