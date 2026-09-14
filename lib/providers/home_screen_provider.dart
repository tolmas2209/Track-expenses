import 'package:flutter/material.dart';
import 'package:track_expenses/models/expense_model.dart';
import 'package:track_expenses/service/database_service.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<ExpenseModel> _transactions = [];
  List<ExpenseModel> get transactions => _transactions;
  double _totalBalance = 0.0;
  double get totalBalance => _totalBalance;
  double _totalIncome = 0.0;
  double get totalIncome => _totalIncome;
  double _totalExpense = 0.0;
  double get totalExpense => _totalExpense;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> deleteTransaction(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await DatabaseService.deleteExpenseFromDB(id);
      await loadTransactions();
    } catch (e) {
      debugPrint("O'chirishda xatolik yuz berdi: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();
    try {
      _transactions = await DatabaseService.getExpensesFromDB();
      _totalBalance = 0.0;
      _totalIncome = 0.0;
      _totalExpense = 0.0;
      for (var item in _transactions) {
        if (item.isIncome) {
          _totalIncome += item.value;
        } else {
          _totalExpense += item.value;
        }
      }
      _totalBalance = _totalIncome - _totalExpense;
    } catch (e) {
      debugPrint("Ma'lumot yuklashda xatolik: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> clearAppCache() async {
    _isLoading = true;
    notifyListeners();
    try {
      await DatabaseService.clearDB();
      _transactions.clear();
      _totalBalance = 0.0;
      _totalIncome = 0.0;
      _totalExpense = 0.0;
    } catch (e) {
      debugPrint("Keshni tozalashda xatolik: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
}
