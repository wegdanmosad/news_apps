import 'package:flutter/material.dart';
import 'package:news_apps/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel category;
  CategoryItem(this.category);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/image/${category.imageName}.png',
        height: MediaQuery.sizeOf(context).height * 0.25,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
