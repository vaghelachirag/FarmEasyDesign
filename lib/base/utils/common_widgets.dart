import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/scan_more_custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

