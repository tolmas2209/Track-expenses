import 'package:flutter/material.dart';
import 'package:track_expenses/const/colors/app_colors.dart';

class TextCustomController extends StatelessWidget {
  const TextCustomController({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(fontSize: 56, fontWeight: FontWeight.w600),
      cursorColor: AppColors.primary,
      cursorHeight: 65,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 120),
          child: Text("\$", style: TextStyle(fontSize: 40, fontWeight: .w600)),
        ),
        hintText: '0.00',
        hintStyle: TextStyle(fontSize: 56, fontWeight: FontWeight.w600),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        border: UnderlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
