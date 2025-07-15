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
    const borderColor = Color(0xFF79747E);
    const labelColor = Color(0xFF49454F);

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
          decoration: InputDecoration(
            hintText: hintText,
            floatingLabelBehavior:FloatingLabelBehavior.always,
            labelText: title,
            alignLabelWithHint: true,
            labelStyle: const TextStyle(
              color: labelColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: borderColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 14),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
