import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/const/colors/app_colors.dart';
import 'package:track_expenses/providers/home_screen_provider.dart';
import 'package:track_expenses/utils/size_extension.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({super.key});

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.7,
      height: context.height,
      color: AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (dialogContext) => CupertinoAlertDialog(
                    title: Text("Confirm to clear the cache?"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () async {
                          await context
                              .read<HomeScreenProvider>()
                              .clearAppCache();

                          if (context.mounted) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Confirm"),
                      ),
                    ],
                  ),
                );
              },
              title: Text("Clear cache"),
              trailing: Icon(Icons.delete),
            ),
            ListTile(
              onTap: () {_animationController.toggle();},
              title: Text("Theme Mode"),
              trailing: SizedBox(
                width: 60,
                height: 60,
                child: LottieBuilder.asset(
                  "assets/lotties/switch.json",
                  controller: _animationController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
