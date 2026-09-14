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
  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _transactions = await DatabaseService.getExpensesFromDB();

      // Har safar yuklanganda hisobni noldan boshlaymiz
      _totalBalance = 0.0;
      _totalIncome = 0.0;
      _totalExpense = 0.0;

      for (var item in _transactions) {
        if (item.isIncome) {
          // ✅ Agar daromad bo'lsa, jami daromadga qo'shamiz
          _totalIncome += item.value;
        } else {
          // ❌ Agar xarajat bo'lsa, jami xarajatga qo'shamiz
          _totalExpense += item.value;
        }
      }

      // Yakuniy balans = Daromadlar - Xarajatlar
      // Boshlang'ich statik summani (masalan 12450) ham qo'shib qo'yishingiz mumkin
      _totalBalance + _totalIncome - _totalExpense;
    } catch (e) {
      debugPrint("Ma'lumot yuklashda xatolik: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
