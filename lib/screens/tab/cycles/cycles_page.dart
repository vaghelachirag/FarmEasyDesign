import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/base/utils/dashline.dart';
import 'package:farmeasy/components/widget/custom_cycle_assign_person.dart';
import 'package:farmeasy/components/widget/custom_start_seeding_btn.dart';
import 'package:farmeasy/components/widget/custom_tab_cycle.dart';
import 'package:farmeasy/components/widget/cycle_status_card.dart';
import 'package:farmeasy/components/widget/searchbar_widget.dart';
import 'package:farmeasy/components/widget/time_range_selection.dart';
import 'package:farmeasy/components/widget/traystatuscard.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/tab/bottombarNavigator/provider/bottomBar_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:farmeasy/screens/tab/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../components/widget/custom_cycle_step_progress_bar.dart';
import '../../../components/widget/custom_steper_widget.dart';

class CyclesPage extends ConsumerWidget {
  const CyclesPage({super.key});

  static const route = "/DashboardPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return SafeArea(child:
    Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
              context,
              onMenuTap: () {
                // open drawer or perform menu action
              },
              onSearchTap: () {
                // trigger search
              },

            ),
            CustomTabCycle(),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: const CycleStatusCard(),
            ),
          ],
        ),
      ),
    ));
  }
}


class CycleStatusCard extends ConsumerWidget {
  const CycleStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cycle = ref.watch(cycleInfoProvider);
    final tasks = ref.watch(taskListProvider);
    String formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

    return  Card(
      child: Column(
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
                Assets.icons.iconArrowRight.path,
                height: 20.h, // Optional: set size
              ),
            ],
          ),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelTextMedium('Started Date • ${formatDate(cycle.startDate)}', 10.sp, AppColors.cycleDateTextBg),
              labelTextMedium('Est End Date • ${formatDate(cycle.startDate)}', 10.sp, AppColors.cycleDateTextBg),
            ],
          ),
          10.verticalSpace,
          StepperWidget(),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              labelTextRegular("Upcoming Seeding in", 12.sp, AppColors.upComingSeedsTextBg),
              5.horizontalSpace,
              Container(
                decoration: AppDecorations.seedingMainBg(),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Text("${cycle.upcomingSeedingDays} Days",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          10.verticalSpace,
          CustomCycleStepProgressBar(progress: 0.1),
           Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child:
            labelTextBold('${(0 * 100).toInt()}%', 14.sp, AppColors.daysToCompleteBg)),
            labelTextBold("14 Days", 14.sp, AppColors.blackColor),
            5.horizontalSpace,
            labelTextRegular("to Complete", 12.sp, AppColors.daysToCompleteBg)
          ],
        ),
          10.verticalSpace,
          _seedingInfoContainer(),
          DashedLine(
            height: 1,
            dashWidth: 6,
            dashSpacing: 4,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Widget _seedingInfoContainer(){
    return Container(
      padding: EdgeInsets.only(left: 15.sp,right: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelTextRegular("Seeding", 16.sp, AppColors.seedingTextBg),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  labelTextRegular('14F Trays of Arugula', 12.sp, AppColors.seedingTrayBg),
                  const SizedBox(width: 4),
                  SvgPicture.asset(Assets.icons.iconInfo.path)
                ],
              ),
              labelTextRegular('0/14 Completed', 12.sp, AppColors.seedingTrayBg),
            ],
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  labelTextRegular('14F Trays of Arugula', 12.sp, AppColors.seedingTrayBg),
                  const SizedBox(width: 4),
                  SvgPicture.asset(Assets.icons.iconInfo.path)
                ],
              ),
              labelTextRegular('0/14 Completed', 12.sp, AppColors.seedingTrayBg),
            ],
          ),
          5.verticalSpace,
          CustomCycleAssignPerson(
            onAssignTap: () {
              // Show modal, navigate, etc.
            },
          ),
        ],
      ),
    );
  }
}
