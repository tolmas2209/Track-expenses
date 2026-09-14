import 'package:flutter/material.dart';
import 'package:track_expenses/const/colors/app_colors.dart';

class IncomeOutcome extends StatelessWidget {
  final double income;
  final double expense;
  const IncomeOutcome({super.key, required this.income, required this.expense});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            spacing: 10,
            children: [
              Container(
                width: 2.5,
                height: 40,
                decoration: BoxDecoration(color: AppColors.tertiary),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.arrow_downward,
                        size: 14,
                        color: AppColors.neutral,
                      ),
                      Text(
                        "INCOME",
                        style: TextStyle(
                          color: AppColors.neutral,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "+\$${income.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            spacing: 10,
            children: [
              Container(
                width: 2.5,
                height: 40,
                decoration: BoxDecoration(color: AppColors.red),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        size: 14,
                        color: AppColors.neutral,
                      ),
                      Text(
                        "OUTCOME",
                        style: TextStyle(
                          color: AppColors.neutral,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "-\$${expense.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
