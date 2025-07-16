import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanMoreCustomButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;

  const ScanMoreCustomButton({
    super.key,
    required this.btnName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed ,
      icon: Icon(Icons.qr_code_scanner, color: Colors.green),
      label: Text(
        btnName,
        style: TextStyle(color: Colors.green,fontSize: 10.sp),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.green),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
