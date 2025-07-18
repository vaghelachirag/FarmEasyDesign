import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget? suffix;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.inputType,
    required this.textInputAction,
    this.obscureText = false,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
            controller: controller,
            keyboardType: inputType,
            autofocus: true,
            textInputAction: textInputAction,
            obscureText: obscureText,
            validator: validator,
            decoration: AppDecorations.mainInputTextDecoration(hintText,title,suffix))
      ],
    );
  }
}
