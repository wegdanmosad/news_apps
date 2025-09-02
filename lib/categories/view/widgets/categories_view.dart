import 'package:flutter/material.dart';
import 'package:news_apps/categories/view/widgets/category_item.dart';
import 'package:news_apps/categories/data/models/category_model.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({required this.onCategorySelected});
  void Function(CategoryModel) onCategorySelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning\n Here is Some News For You',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  onCategorySelected(CategoryModel.categories[index]);
                },
                child: CategoryItem(CategoryModel.categories[index]),
              ),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: CategoryModel.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
