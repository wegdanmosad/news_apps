import 'package:flutter/material.dart';
import 'package:news_apps/app_theme.dart';
import 'package:news_apps/categories/categories_view.dart';
import 'package:news_apps/drawer/home_drawer.dart';
import 'package:news_apps/drawer/settings_provider.dart';
import 'package:news_apps/models/category_model.dart';
import 'package:news_apps/news/news_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !isSearching,
        title: !isSearching
            ? Text(selectedCategory == null ? 'Home' : selectedCategory!.name)
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: settingsProvider.isDark
                        ? AppTheme.white
                        : AppTheme.black,
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  style: TextStyle(
                    color: settingsProvider.isDark
                        ? AppTheme.white
                        : AppTheme.black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isSearching = true;
                        });
                      },
                      icon: Icon(
                        Icons.search,
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isSearching = false;
                          searchController.clear();
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
        actions: [
          if (!isSearching)
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
              icon: Icon(Icons.search),
            ),
        ],
      ),
      drawer: HomeDrawer(onGoToHomeClicked: resetSelectedCategory),
      body: selectedCategory == null
          ? CategoriesView(onCategorySelected: onCategorySelected)
          : NewsView(
              categoryId: selectedCategory!.id,
              searchQuery: searchQuery,
            ),
    );
  }

  void onCategorySelected(CategoryModel category) {
    selectedCategory = category;
    setState(() {});
  }

  void resetSelectedCategory() {
    if (selectedCategory == null) return;
    selectedCategory = null;
    setState(() {});
  }
}
