import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGoogleButton extends StatelessWidget {
  final VoidCallback onTap;

  const CustomGoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: 12.sp, horizontal: 20.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFEFF0F6), // Border color
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x99F4F5FA), // Inner shadow (60%)
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.google.image(
              width: 20.sp,
              height: 20.sp,
            ),
           10.horizontalSpace,
            Text(
              context.l10n.continueWithGoogle,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
