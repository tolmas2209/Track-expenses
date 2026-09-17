import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/const/colors/app_colors.dart';
import 'package:track_expenses/providers/home_screen_provider.dart';
import '../models/expense_model.dart';

class RecentTrans extends StatefulWidget {
  final ExpenseModel expenseModel;
  const RecentTrans({super.key, required this.expenseModel});
  @override
  State<RecentTrans> createState() => _RecentTransState();
}

class _RecentTransState extends State<RecentTrans> {
  IconData _getIconForCategory(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.home:
        return Icons.home;
      case ExpenseCategory.food:
        return Icons.restaurant_menu;
      case ExpenseCategory.transit:
        return Icons.directions_car_filled;
      case ExpenseCategory.shop:
        return Icons.shopping_bag;
      case ExpenseCategory.bills:
        return Icons.flash_on;
      case ExpenseCategory.more:
        return Icons.more_horiz;
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return "$day.$month.$year";
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.expenseModel;
    final homeProvider = context.read<HomeScreenProvider>();
    final formattedDate = _formatDate(item.createdAt);
    final subtitleText = (item.note == null || item.note!.isEmpty)
        ? formattedDate
        : "${item.note!} • $formattedDate";
    final List<String> rasmYollari = homeProvider.getParsedImages(item.image);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.primary,
              radius: 24,
              child: Icon(_getIconForCategory(item.type), size: 24),
            ),
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.type.name.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  subtitleText,
                  style: TextStyle(color: AppColors.neutral, fontSize: 14),
                ),
              ],
            ),
            Spacer(),
            Text(
              "${item.isIncome ? '+' : '-'}\$${item.value.toStringAsFixed(2)}",
              style: TextStyle(
                color: item.isIncome ? AppColors.tertiary : AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (rasmYollari.isNotEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Wrap(
                alignment: .center,
                spacing: 8,
                runSpacing: 8,
                children: List.generate(rasmYollari.length, (imgIndex) {
                  final rasmFayli = File(rasmYollari[imgIndex]);
                  if (!rasmFayli.existsSync()) return SizedBox();
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) => Dialog(
                            child: Image.file(rasmFayli, fit: BoxFit.contain),
                          ),
                        );
                      },
                      child: Image.file(
                        rasmFayli,
                        width: 94,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 94,
                            height: 60,
                            color: Colors.grey,
                            child: Icon(Icons.broken_image, size: 20),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
      ],
    );
  }
}
