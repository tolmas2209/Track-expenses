import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:track_expenses/models/expense_model.dart';
import 'package:track_expenses/service/database_service.dart';

class DetailScreenProvider extends ChangeNotifier {
  List<File> noteRasmlari = [];
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
      final String rasmlarYollari = noteRasmlari
          .map((fayl) => fayl.path)
          .join(',');
      await DatabaseService.addExpensesToDB(
        ExpenseModel(
          value: amount,
          type: currentCategory["type"],
          image: rasmlarYollari.isNotEmpty
              ? rasmlarYollari
              : currentCategory["title"].toString().toLowerCase(),
          note: scrollController.text.trim(),
          id: DateTime.now().millisecondsSinceEpoch,
          isIncome: _isIncome,
          createdAt: DateTime.now(),
        ),
      );
      valueController.clear();
      scrollController.clear();
      noteRasmlari.clear();
      _selectedIndex = 0;
      _isIncome = false;
      notifyListeners();
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

  Future<void> pickImageFromGallery({required Function onSuccess}) async {
    final picker = ImagePicker();
    final result = await picker.pickMultiImage(limit: 5, imageQuality: 100);
    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        noteRasmlari.add(File(result[i].path));
      }
      onSuccess();
      notifyListeners();
    }
  }

  Future<void> pickImageFromCamera({required Function onSuccess}) async {
    final picker = ImagePicker();
    final result = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (result != null) {
      noteRasmlari.add(File(result.path));
      onSuccess();
      notifyListeners();
    }
  }
}
