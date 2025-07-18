import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/base/utils/dashline.dart';
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

    String formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Tray Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelTextRegular(cycle.cycleName, 12.sp, AppColors.blackColor),
                SvgPicture.asset(Assets.icons.iconArrowRight.path)
              ],
            ),
            SizedBox(height: 3.h),
            // Dates Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelTextMedium('Started Date • ${formatDate(cycle.startDate)}', 10.sp, AppColors.blackColor),
                labelTextMedium('Est End Date • ${formatDate(cycle.startDate)}', 10.sp, AppColors.blackColor),
              ],
            ),
            SizedBox(height: 8.h),
            // Progress Icons Row
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProgressIcon(Assets.icons.iconSeeds.path, true),
                _buildProgressIcon(Assets.icons.iconPlant.path, false),
                _buildProgressIcon(Assets.icons.iconDrop.path, false),
                _buildProgressIcon(Assets.icons.iconHummer.path, false),
              ],
            ),
            SizedBox(height: 16.h),
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Upcoming Seeding in", style: TextStyle(fontSize: 12.sp)),
                5.horizontalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  child: Text("${cycle.upcomingSeedingDays} Days",
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIcon(String path, bool completed) {
    return CircleAvatar(
      backgroundColor: completed ? Colors.green : Colors.grey.shade200,
      radius: 18.r,
      child: SvgPicture.asset(path),
    );
  }
}
