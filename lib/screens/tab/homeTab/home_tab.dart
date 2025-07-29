import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/tab/bottombarNavigator/provider/bottomBar_provider.dart';
import 'package:farmeasy/screens/tab/cycles/cycles_page.dart';
import 'package:farmeasy/screens/tab/dashboard/dashboard_page.dart';
import 'package:farmeasy/screens/tab/seeding/seeding_screen_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../base/utils/utils.dart';


class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});


  static const route = "/HomeTab";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Utils.hideKeyboard(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final selectedIndex = ref.watch(bottomNavIndexProvider);
    final currentIndex = ref.watch(bottomNavIndexProvider);


    final List<Widget> screens = [
      const DashboardPage(),
      const CyclesPage(),
      const SeedingScreenPage(),
    ];

    return Scaffold(
      body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => ref.read(bottomNavIndexProvider.notifier).state = index,
          items: [
            BottomNavigationBarItem(
              icon: bottomBarIcon(
                Assets.icons.tabHome.path,
                isSelected: currentIndex == 0,
              ),
              label: context.l10n.home,
            ),
            BottomNavigationBarItem(
              icon: bottomBarIcon(
                Assets.icons.tabCycle.path,
                isSelected: currentIndex == 1,
              ),
              label: context.l10n.cycles,
            ),
            BottomNavigationBarItem(
              icon: bottomBarIcon(
                Assets.icons.tabHandbook.path,
                isSelected: currentIndex == 2,
              ),
              label: context.l10n.handbook,
            ),
          ],
        )
    );
  }
}

Widget bottomBarIcon(String path, {required bool isSelected}) {
  return Container(
    decoration: BoxDecoration(
      color: isSelected ? AppColors.bottomBarSelectionColor : Colors.transparent,
      borderRadius: BorderRadius.circular(20.r),
    ),
    padding: EdgeInsets.all(8.w),
    child: SvgPicture.asset(
     path,
      colorFilter: ColorFilter.mode(
        isSelected ? AppColors.bottomBarSelectionTextColor : AppColors.bottomBarSelectionTextColor,
        BlendMode.srcIn,
      ),
    ),
  );
}
