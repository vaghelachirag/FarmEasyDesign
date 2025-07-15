import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/dashline.dart';
import 'package:farmeasy/components/widget/custom_start_seeding_btn.dart';
import 'package:farmeasy/components/widget/cycle_status_card.dart';
import 'package:farmeasy/components/widget/searchbar_widget.dart';
import 'package:farmeasy/components/widget/step_progress_widget.dart';
import 'package:farmeasy/components/widget/time_range_selection.dart';
import 'package:farmeasy/components/widget/traystatuscard.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/tab/bottombarNavigator/provider/bottomBar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SeedingScreenPage extends ConsumerWidget {
  const SeedingScreenPage({super.key});

  static const route = "/StartSeedingPage";

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
            const StepProgressWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _circleButton(Icons.qr_code_scanner),
                _circleButton(Icons.flash_on),
                _circleButton(Icons.more_vert),
              ],
            ),
            SizedBox(height: 20.h),
            buildTopBar(),
            _scanQrExpand()
          ],
        ),
      ),
    ));
  }
}

Widget _circleButton(IconData icon) {
  return Container(
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
    ),
    padding: EdgeInsets.all(10.r),
    child: Icon(icon, size: 20.r),
  );
}

Widget _scanQrExpand() {
    return Center(
      child: GestureDetector(
        onTap: () {
          // TODO: Implement scan logic
        },
        child: Container(
          height: 240.h,
          width: 240.w,
          decoration: BoxDecoration(
            color: const Color(0xFFB2D8A2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background Icon
              Opacity(
                opacity: 0.1,
                child: Icon(Icons.qr_code, size: 160.r),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tap to Scan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Icon(Icons.touch_app, size: 24.r, color: Colors.white),
                ],
              ),

              // Corner Decorations
              Positioned(top: 0, left: 0, child: _corner()),
              Positioned(top: 0, right: 0, child: _corner()),
              Positioned(bottom: 0, left: 0, child: _corner()),
              Positioned(bottom: 0, right: 0, child: _corner()),
            ],
          ),
        ),
      ),
    );
  }

Widget buildTopBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Left circular scan icon
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10.r),
        child: Icon(Icons.qr_code_scanner, size: 20.r),
      ),

      // Right icons
      Row(
        children: [
          SvgPicture.asset(Assets.icons.iconFlash.path,color: Colors.grey,),
        ],
      ),
    ],
  );
}

Widget _corner() {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.green.shade800, width: 3),
        left: BorderSide(color: Colors.green.shade800, width: 3),
      ),
    ),
  );
}