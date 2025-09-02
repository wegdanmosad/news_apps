import 'package:flutter/material.dart';
import 'package:news_apps/home/view/widgets/drawer/settings_provider.dart';
import 'package:news_apps/categories/data/models/category_model.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/image/${settingsProvider.isDark ? category.darkImage : category.lightImage}.png',
        height: MediaQuery.sizeOf(context).height * 0.25,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
