import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/dashline.dart';
import 'package:farmeasy/components/widget/custom_start_seeding_btn.dart';
import 'package:farmeasy/components/widget/custom_tab_cycle.dart';
import 'package:farmeasy/components/widget/cycle_status_card.dart';
import 'package:farmeasy/components/widget/searchbar_widget.dart';
import 'package:farmeasy/components/widget/time_range_selection.dart';
import 'package:farmeasy/components/widget/traystatuscard.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/tab/bottombarNavigator/provider/bottomBar_provider.dart';
import 'package:farmeasy/screens/tab/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';



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
            CycleStatusCard(
              totalCycles: 12,
              date: '12/07/2025',
              stageData: {
                "Seeding": 3,
                "Germination": 2,
                "Fertigation": 4,
                "Harvesting": 3,
              },
            ),
          ],
        ),
      ),
    ));
  }
}
