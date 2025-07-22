import 'dart:io';

import 'package:farmeasy/screens/login/login_screen.dart';
import 'package:farmeasy/screens/splash/splash_screen.dart';
import 'package:farmeasy/screens/seedingProcess/seedingTrays/addPersonDetail/add_person_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../screens/seedingProcess/harvestingTrays/harvesting_trays_screens.dart';
import '../../screens/seedingProcess/moveToFertigation/move_to_fertigation_screen.dart';
import '../../screens/seedingProcess/movingToGermination/moving_to_germination.dart';
import '../../screens/seedingProcess/seedingTrays/seeding_trays_screen.dart';
import '../../screens/tab/dashboard/dashboard_page.dart';
import '../../screens/tab/homeTab/home_tab.dart';
import '../../screens/tab/seeding/seeding_screen_page.dart';

class AppRoute {
  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return navigatePushToScreen(SplashScreen(), settings);
      case LoginScreen.route:
        return navigatePushToScreen(LoginScreen(), settings);
      case DashboardPage.route:
        return navigatePushToScreen(DashboardPage(), settings);
      case HomeTab.route:
        return navigatePushToScreen(HomeTab(), settings);
      case AddPersonDetailScreen.route:
        return navigatePushToScreen(AddPersonDetailScreen(), settings);
      case SeedingTraysScreen.route:
        return navigatePushToScreen(SeedingTraysScreen(), settings);
      case SeedingScreenPage.route:
        return navigatePushToScreen(SeedingScreenPage(), settings);
      case MovingToGerminationScreen.route:
        return navigatePushToScreen(MovingToGerminationScreen(), settings);
      case MoveToFertigationScreen.route:
        return navigatePushToScreen(MoveToFertigationScreen(), settings);
      case HarvestingTraysScreens.route:
        return navigatePushToScreen(HarvestingTraysScreens(), settings);
      default:
        return null;
    }
  }
}

PageRoute navigatePushToScreen(Widget screen, settings) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (context) => screen, settings: settings);
  } else {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: myTransitionBuilder,
      transitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black12.withOpacity(0.5),
    );
  }
}

Widget myTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return CircularRevealTransition(animation: animation, child: child);
}

class CircularRevealTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const CircularRevealTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ClipPath(
          clipper: CircularRevealClipper(animation.value),
          child: child,
        );
      },
      child: child,
    );
  }
}

class CircularRevealClipper extends CustomClipper<Path> {
  final double radius;

  CircularRevealClipper(this.radius);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), // Center of the screen
        radius: radius * size.longestSide,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) {
    return radius != oldClipper.radius;
  }
}
