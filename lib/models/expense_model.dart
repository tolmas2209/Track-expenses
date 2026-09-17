import 'package:flutter/material.dart';

enum ExpenseCategory { home, food, transit, shop, bills, more }

extension ExpenseCategoryExtension on ExpenseCategory {
  IconData get icon {
    switch (this) {
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

  String get title => name.toUpperCase();
}

class ExpenseModel {
  double value;
  ExpenseCategory type;
  String? note;
  String? image;
  int id;
  bool isIncome;
  DateTime createdAt;
  ExpenseModel({
    required this.value,
    required this.type,
    this.note,
    this.image,
    required this.id,
    required this.isIncome,
    required this.createdAt,
  });
  List<String> get rasmYollari {
    if (image == null || image!.isEmpty) return [];
    final String imageField = image!.toString();
    if (imageField.contains('/') || imageField.contains('cache')) {
      return imageField.split(',').where((e) => e.trim().isNotEmpty).toList();
    }
    return [];
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      value: (json['value'] as num).toDouble(),
      type: ExpenseCategory.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ExpenseCategory.more,
      ),
      note: json['note'],
      image: json['image'],
      id: json['id'] as int,
      isIncome: json['isIncome'] == 1,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "type": type.name,
    "note": note,
    "image": image,
    "isIncome": isIncome ? 1 : 0,
    "createdAt": createdAt.toIso8601String(),
  };
}
