import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/providers/home_screen_provider.dart';
import 'package:track_expenses/screens/detail_screen.dart';
import 'package:track_expenses/widgets/add_send.dart';
import 'package:track_expenses/widgets/appbar_custom.dart';
import 'package:track_expenses/widgets/balance_counter_widget.dart';
import 'package:track_expenses/widgets/drawer_custom.dart';
import 'package:track_expenses/widgets/income_outcome.dart';
import 'package:track_expenses/widgets/recent_trans.dart';

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
                                  return GestureDetector(
                                    onLongPress: () {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (dialogContext) =>
                                            CupertinoAlertDialog(
                                              title: Text("Delete Transaction"),
                                              content: Text(
                                                "Do you want to delete this ${(item.note != null && item.note!.isNotEmpty) ? item.note : item.type.name.toUpperCase()} transaction?",
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
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: RecentTrans(expenseModel: item),
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
