import 'package:flutter/material.dart';
import 'package:track_expenses/const/colors/app_colors.dart';

class SnackBarCustom {
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).height * 0.85,
          left: 20,
          right: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(50),
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(message, style: TextStyle(fontSize: 14)),
        backgroundColor: AppColors.red,
        showCloseIcon: true,
      ),
    );
  }

  static void showSuccesSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        margin: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).height * 0.85,
          left: 20,
          right: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(50),
        ),
        behavior: SnackBarBehavior.floating,
        content: Row(
          spacing: 10,
          children: [
            Icon(Icons.verified, color: AppColors.secondary),
            Text(message, style: TextStyle(fontSize: 14)),
          ],
        ),
        backgroundColor: AppColors.tertiary,
      ),
    );
  }
}
