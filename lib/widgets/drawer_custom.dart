import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/const/colors/app_colors.dart';
import 'package:track_expenses/providers/home_screen_provider.dart';
import 'package:track_expenses/utils/size_extension.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.5,
      height: context.height,
      color: AppColors.white,
      child: Column(
        children: [
          SafeArea(
            child: ListTile(
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
          ),
        ],
      ),
    );
  }
}
