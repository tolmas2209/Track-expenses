import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/const/colors/app_colors.dart';
import 'package:track_expenses/providers/detail_screen_provider.dart';
import 'package:track_expenses/service/permission_service.dart';
import 'package:track_expenses/widgets/add_send.dart';
import 'package:track_expenses/widgets/appbar_custom.dart';
import 'package:track_expenses/widgets/category_grid_widget.dart';
import 'package:track_expenses/widgets/number_input_field.dart';
import 'package:track_expenses/widgets/text_custom_controller.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailScreenProvider(),
      child: Consumer<DetailScreenProvider>(
        builder: (context, provider, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppbarCustom(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
                title: "New Entry",
                action: TextButton(
                  onPressed: () async {
                    final bool isSaved = await provider.saveEntry(context);
                    if (isSaved && context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text("SAVE"),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    FadeInUp(
                      child: Text("AMOUNT", style: TextStyle(fontSize: 16)),
                    ),
                    FadeInUp(
                      child: TextCustomController(
                        controller: provider.valueController,
                      ),
                    ),
                    SizedBox(height: 10),
                    FadeInUp(
                      child: AddSend(
                        onAddFunds: "EXPENSE",
                        onSend: "INCOME",
                        initialIndex: provider.isIncome ? 1 : 0,
                        onChanged: (index) {
                          provider.setTransactionType(index == 1);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: Text(
                              "ADD image from ?",
                              textAlign: TextAlign.center,
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    PermissionService.requestCameraPermission();
                                    provider.pickImageFromCamera(
                                      onSuccess: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  child: Text("Camera"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    PermissionService.requestGalleryPermission();
                                    provider.pickImageFromGallery(
                                      onSuccess: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  child: Text("Gallery"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "+ Add image",
                        style: TextStyle(color: AppColors.tertiary),
                      ),
                    ),
                    SizedBox(height: 20),
                    provider.noteRasmlari.isNotEmpty
                        ? SizedBox(
                            height: 150,
                            child: ListView.builder(
                              itemCount: provider.noteRasmlari.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final rasm = provider.noteRasmlari[index];
                                return Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: InkWell(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Image.file(rasm, fit: .cover),
                                        ),
                                      ),
                                      child: Image.file(
                                        rasm,
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("CATEGORY", style: TextStyle(fontSize: 14)),
                          Divider(color: AppColors.neutral),
                        ],
                      ),
                    ),
                    FadeInDown(child: CategoryGridWidget()),
                    NumberInputField(
                      hintText: "ADD NOTE",
                      controller: provider.scrollController,
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
