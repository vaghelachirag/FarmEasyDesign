import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/screens/splash/provider/splash_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';

import '../../../generator/assets.gen.dart';

class HarvestingTraysScreens extends ConsumerStatefulWidget {
  static const route = "/HarvestingTraysScreens";

  const HarvestingTraysScreens({super.key});

  @override
  ConsumerState<HarvestingTraysScreens> createState() => _HarvestingTraysScreens();
}

class _HarvestingTraysScreens extends ConsumerState<HarvestingTraysScreens>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cycles = ref.watch(cyclesProvider);
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final cycleStatus = args['cycleStatus'];

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return SafeArea(child: Scaffold(
      appBar: getActionbar("Harvesting Trays"),
      body:  SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ],
          ),
        ),
      ),
    ));
  }
}