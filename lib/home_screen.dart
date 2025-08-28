import 'package:flutter/material.dart';
import 'package:news_apps/app_theme.dart';
import 'package:news_apps/categories/categories_view.dart';
import 'package:news_apps/drawer/home_drawer.dart';
import 'package:news_apps/models/category_model.dart';
import 'package:news_apps/news/news_view.dart';

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
                  border: Border.all(color: AppTheme.white),
                ),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  style: TextStyle(color: AppTheme.white),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: AppTheme.white,
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

                      icon: Icon(Icons.search, color: AppTheme.white),
                    ),

                    suffixIcon: IconButton(
                      icon: Icon(Icons.close, color: AppTheme.white),
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
/**import 'package:flutter/material.dart';
import 'package:news_apps/app_theme.dart';
import 'package:news_apps/news/news_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = ""; // ✅ this will be shared with NewsView
  String selectedCategory = "general"; // example default category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search news...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
        backgroundColor: AppTheme.primary,
      ),
      body: NewsView(
        categoryId: selectedCategory,
        searchQuery: searchQuery, // ✅ pass it down
      ),
    );
  }
}
 */