import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/dashboard/dashboard_page.dart';
import 'package:farmeasy/screens/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../base/utils/app_colors.dart';
import '../bottombarNavigator/provider/bottomBar_provider.dart'; // where you placed the provider

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});


  static const route = "/HomeTab";

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final screenWidth = MediaQuery.of(context).size.width;
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    final List<Map<String, dynamic>> navItems = [
      {"icon": Assets.icons.tabHome.path, "title": "Home"},
      {"icon": Assets.icons.tabCycle.path, "title": "Cycles"},
      {"icon": Assets.icons.tabHandbook.path, "title": "Handbook"},
    ];

    final List<Widget> screens = [
      const LoginScreen(),
      const DashboardPage(),
      const LoginScreen(),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) => ref.read(bottomNavIndexProvider.notifier).state = index,
        currentIndex: selectedIndex,
        activeColor: AppColors.blackColor,
        inactiveColor: AppColors.basePrimaryColor,
        items: List.generate(
          navItems.length,
              (index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              navItems[index]["icon"],
              height: 30.sp,
              width: 30.sp,
              colorFilter: ColorFilter.mode(
                index == selectedIndex
                    ? AppColors.blackColor
                    :  AppColors.basePrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: navItems[index]["title"],
          ),
        ),
      ),
    );
  }
}
