import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomElevatedButton({
    super.key,
    required this.btnName,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 10.0,
    this.height = 48,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFF59BE4C), // #59BE4C
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: const Color(0xFF3A7F0D), width: 1), // border 1px
          boxShadow: const [
            BoxShadow(
              color: Color(0x7A3A7F0D), // #3A7F0D with 48% opacity
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            btnName,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
