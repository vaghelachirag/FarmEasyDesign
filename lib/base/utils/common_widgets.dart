import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/scan_more_custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/widget/top_header_home_page.dart';
import '../../generator/assets.gen.dart';
import 'app_constant.dart';

EdgeInsets authScreenPadding() =>
    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp);

EdgeInsets screenPadding() =>
    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp);

BoxDecoration boxDecoration(Color color, Color border) =>
    BoxDecoration(
      color:color,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color:  border, // very light green border
        width: 1,
      ),
    );


// Label Text Bold
Text labelTextBold(hint, double fontSize, Color labelTextColor) {
  return  Text(
    hint,
    style: TextStyle(
        color: labelTextColor,
        fontSize: ScreenUtil().setSp(fontSize),
        fontFamily: AppConstant.labelFrontBold),
  );
}

// Label Text Medium
Text labelTextMedium(hint, double fontSize, Color labelTextColor) {
  return  Text(
    hint,
    style: TextStyle(
        color: labelTextColor,
        fontSize: ScreenUtil().setSp(fontSize),
        fontFamily: AppConstant.labelFrontMedium),
  );
}

// Label Text Regular
Text labelTextRegular(hint, double fontSize, Color labelTextColor) {
  return  Text(
    hint,
    style: TextStyle(
        color: labelTextColor,
        fontSize: ScreenUtil().setSp(fontSize),
        fontFamily: AppConstant.labelFrontRegular),
  );
}

Container totalRunningCycleWidget(BuildContext context){
  final width = MediaQuery.of(context).size.width;
  final isMobile = width < 600;
 return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstant.cardCornerRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child:
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TopHeaderHomePage(
                          title: 'Total Running Cycles',
                          date: '12/07/2025',
                          assetPath: Assets.icons.syncIcon.path,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Total number
                    Text(
                      '8',
                      style: TextStyle(
                        fontSize: isMobile ? 32 : 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              /// Right image
              SizedBox(
                width: isMobile ? 80.w : 100.w, // Responsive control
                child: SvgPicture.asset(
                  Assets.images.blockChaiIcon.path,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ],
      )
  );
}

