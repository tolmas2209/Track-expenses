import 'package:flutter/material.dart';
import 'package:track_expenses/gen/assets.gen.dart';

class OnboardingProvider extends ChangeNotifier {
  List<Map> malumotlar = [
    {
      "icon": Assets.icons.container,
      "title": "Track Everything",
      "description":
          "Log your daily income and expenses instantly. No clutter, just the data you need.",
    },
    {
      "icon": Assets.icons.container,
      "title": "See the Big Picture",
      "description":
          "Visualize your spending habits with elegant charts. Know exactly where you stand.",
    },
    {
      "icon": Assets.icons.container,
      "title": "Own Your Budgets",
      "description":
          "Make smarter financial decisions every single day. Let's get your money organized.",
    },
  ];
  int currentPage = 0;
  void pageOzgarganda(int index) {
    currentPage = index;
    notifyListeners();
  }
}
