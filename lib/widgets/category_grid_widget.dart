import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/const/colors/app_colors.dart';
import 'package:track_expenses/providers/detail_screen_provider.dart';

class CategoryGridWidget extends StatelessWidget {
  const CategoryGridWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailScreenProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: provider.categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          final item = provider.categories[index];
          final bool isSelected = provider.selectedIndex == index;
          return GestureDetector(
            onTap: () {
              provider.selectCategory(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: isSelected
                      ? AppColors.primary
                      : AppColors.secondary,
                  child: Icon(
                    isSelected ? item["activeIcon"] : item["icon"],
                    color: isSelected ? AppColors.white : AppColors.neutral,
                    size: 24,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  item["title"],
                  style: TextStyle(
                    color: isSelected ? AppColors.primary : AppColors.neutral,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
