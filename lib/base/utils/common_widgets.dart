import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

EdgeInsets authScreenPadding() =>
    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp);

EdgeInsets screenPadding() =>
    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp);

BoxDecoration boxDecoration() =>
    BoxDecoration(
      color: Color(0xFFF0F4EC),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: const Color(0xFFEFF3EC), // very light green border
        width: 1,
      ),
    );