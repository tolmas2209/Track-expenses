import 'package:flutter/material.dart';
import 'package:track_expenses/models/expense_model.dart';
import 'package:track_expenses/service/database_service.dart';

class DetailScreenProvider extends ChangeNotifier {
  final TextEditingController scrollController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  bool _isIncome = false;
  bool get isIncome => _isIncome;
  void setTransactionType(bool isIncomeType) {
    _isIncome = isIncomeType;
    notifyListeners();
  }

  final List<Map<String, dynamic>> categories = [
    {
      "title": "HOME",
      "icon": Icons.home_outlined,
      "activeIcon": Icons.home,
      "type": ExpenseCategory.home,
    },
    {
      "title": "FOOD",
      "icon": Icons.restaurant_menu,
      "activeIcon": Icons.restaurant_menu,
      "type": ExpenseCategory.food,
    },
    {
      "title": "TRANSIT",
      "icon": Icons.directions_car_filled_outlined,
      "activeIcon": Icons.directions_car_filled,
      "type": ExpenseCategory.transit,
    },
    {
      "title": "SHOP",
      "icon": Icons.shopping_bag_outlined,
      "activeIcon": Icons.shopping_bag,
      "type": ExpenseCategory.shop,
    },
    {
      "title": "BILLS",
      "icon": Icons.flash_on,
      "activeIcon": Icons.flash_on,
      "type": ExpenseCategory.bills,
    },
    {
      "title": "MORE",
      "icon": Icons.more_horiz,
      "activeIcon": Icons.more_horiz,
      "type": ExpenseCategory.more,
    },
  ];
  void selectCategory(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<bool> saveEntry(BuildContext context) async {
    String rawText = valueController.text.trim();
    rawText = rawText.replaceAll(',', '.');
    final double amount = double.tryParse(rawText) ?? 0.0;
    final currentCategory = categories[_selectedIndex];
    try {
      await DatabaseService.addExpensesToDB(
        ExpenseModel(
          value: amount,
          type: currentCategory["type"],
          image: currentCategory["title"].toString().toLowerCase(),
          note: scrollController.text.trim(),
          id: DateTime.now().millisecondsSinceEpoch,
          isIncome: _isIncome,
          createdAt: DateTime.now(),
        ),
      );
      valueController.clear();
      scrollController.clear();
      _selectedIndex = 0;
      _isIncome = false;
      return true;
    } catch (e) {
      debugPrint("Bazaga saqlashda xatolik: $e");
      return false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    valueController.dispose();
    super.dispose();
  }
}
