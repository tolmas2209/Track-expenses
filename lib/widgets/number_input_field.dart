import 'package:flutter/material.dart';
import 'package:track_expenses/const/colors/app_colors.dart';

class NumberInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const NumberInputField({
    super.key,
    required this.hintText,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 16, color: AppColors.primary),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.neutral,
          ),
          filled: true,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.neutral),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.neutral),
          ),
        ),
      ),
    );
  }
}
