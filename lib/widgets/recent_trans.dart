import 'package:flutter/material.dart';
import 'package:track_expenses/const/colors/app_colors.dart';

class RecentTrans extends StatelessWidget {
  const RecentTrans({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.action,
    required this.actionColor,
  });
  final IconData leading;
  final String title;
  final String subtitle;
  final String action;
  final Color actionColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.primary,
              radius: 24,
              child: Icon(leading, size: 24),
            ),
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: AppColors.neutral, fontSize: 14),
                ),
              ],
            ),
            Spacer(),
            Text(
              action,
              style: TextStyle(
                color: actionColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Divider(height: 20, indent: 20, color: AppColors.neutral),
      ],
    );
  }
}
