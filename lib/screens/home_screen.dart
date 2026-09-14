import 'dart:io'; // 📁 File bilan ishlash uchun shart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/const/colors/app_colors.dart';
import 'package:track_expenses/providers/home_screen_provider.dart';
import 'package:track_expenses/screens/detail_screen.dart';
import 'package:track_expenses/widgets/add_send.dart';
import 'package:track_expenses/widgets/appbar_custom.dart';
import 'package:track_expenses/widgets/balance_counter_widget.dart';
import 'package:track_expenses/widgets/drawer_custom.dart';
import 'package:track_expenses/widgets/income_outcome.dart';
import 'package:track_expenses/widgets/recent_trans.dart';
import '../models/expense_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenProvider>().loadTransactions();
    });
  }

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeScreenProvider>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCustom(),
      appBar: AppbarCustom(
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        title: 'Overview',
        action: IconButton(
          onPressed: () {},
          icon: Icon(Icons.account_circle_outlined, size: 30),
        ),
      ),
      body: homeProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInDown(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Text("TOTAL BALANCE", style: TextStyle(fontSize: 16)),
                        BalanceCounterWidget(
                          value: homeProvider.totalBalance,
                          size: 30,
                        ),
                        SizedBox(height: 20),
                        AddSend(onAddFunds: "ADD FUNDS", onSend: "SEND"),
                        IconButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(),
                              ),
                            );
                            if (mounted) {
                              context
                                  .read<HomeScreenProvider>()
                                  .loadTransactions();
                            }
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  FadeInUp(
                    child: IncomeOutcome(
                      income: homeProvider.totalIncome,
                      expense: homeProvider.totalExpense,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("VIEW ALL", style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  FadeInDown(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        homeProvider.transactions.isEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 40),
                                child: Text(
                                  "Hozircha kirim-chiqimlar yo'q",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: homeProvider.transactions.length,
                                itemBuilder: (context, index) {
                                  final item = homeProvider.transactions[index];
                                  final formattedDate = _formatDate(
                                    item.createdAt,
                                  );
                                  final subtitleText =
                                      (item.note == null || item.note!.isEmpty)
                                      ? formattedDate
                                      : "${item.note!} • $formattedDate";
                                  List<String> rasmYollari = [];
                                  final String imageField = item.image
                                      .toString();

                                  if (imageField.contains('/') ||
                                      imageField.contains('cache')) {
                                    rasmYollari = imageField
                                        .split(',')
                                        .where((e) => e.trim().isNotEmpty)
                                        .toList();
                                  }

                                  return GestureDetector(
                                    onLongPress: () {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (dialogContext) =>
                                            CupertinoAlertDialog(
                                              title: Text("Delete Transaction"),
                                              content: Text(
                                                "Do you want to delete this ${(item.note != null && item.note!.isNotEmpty) ? item.note : item.type.name} transaction?",
                                              ),
                                              actions: [
                                                CupertinoDialogAction(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                        dialogContext,
                                                      ),
                                                  child: Text("Cancel"),
                                                ),
                                                CupertinoDialogAction(
                                                  isDestructiveAction: true,
                                                  onPressed: () async {
                                                    await context
                                                        .read<
                                                          HomeScreenProvider
                                                        >()
                                                        .deleteTransaction(
                                                          item.id,
                                                        );
                                                    if (context.mounted) {
                                                      Navigator.pop(
                                                        dialogContext,
                                                      );
                                                    }
                                                  },
                                                  child: Text("Delete"),
                                                ),
                                              ],
                                            ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RecentTrans(
                                          leading: _getIconForCategory(
                                            item.type,
                                          ),
                                          title: item.type.name.toUpperCase(),
                                          subtitle: subtitleText,
                                          action:
                                              "${item.isIncome ? '+' : '-'}\$${item.value.toStringAsFixed(2)}",
                                          actionColor: item.isIncome
                                              ? AppColors.tertiary
                                              : AppColors.primary,
                                        ),
                                        if (rasmYollari.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 20,
                                              top: 8,
                                              bottom: 8,
                                            ),
                                            child: Wrap(
                                              spacing: 8,
                                              runSpacing: 8,
                                              children: List.generate(
                                                rasmYollari.length,
                                                (imgIndex) {
                                                  final rasmFayli = File(
                                                    rasmYollari[imgIndex],
                                                  );
                                                  if (!rasmFayli
                                                      .existsSync()) {
                                                    return SizedBox();
                                                  }
                                    
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (
                                                                dialogContext,
                                                              ) => Dialog(
                                                                child: Image.file(
                                                                  rasmFayli,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                        );
                                                      },
                                                      child: Image.file(
                                                        rasmFayli,
                                                        width: 80,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) {
                                                              return Container(
                                                                width: 80,
                                                                height: 60,
                                                                color: Colors
                                                                    .grey,
                                                                child: Icon(
                                                                  Icons
                                                                      .broken_image,
                                                                  size: 20,
                                                                ),
                                                              );
                                                            },
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        SizedBox(height: 8),
                                        Divider(height: 1, thickness: 0.5),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
