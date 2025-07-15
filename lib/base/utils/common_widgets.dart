import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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