// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:news_apps/app_theme.dart';
import 'package:news_apps/home/view/widgets/drawer/settings_provider.dart';
import 'package:news_apps/news/data/models/news.dart';
import 'package:news_apps/sources/data/models/source.dart';
import 'package:news_apps/news/view_model/news_view_model.dart';
import 'package:news_apps/news/view/widgets/news_item.dart';
import 'package:news_apps/sources/view/widgets/tab_item.dart';
import 'package:news_apps/sources/view_model/sources_view_model.dart';
import 'package:news_apps/widget/error_indicator.dart';
import 'package:news_apps/widget/loading_indicator.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  String categoryId;
  String searchQuery;

  NewsView({required this.categoryId, required this.searchQuery});
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  SourcesViewModel sourcesViewModel = SourcesViewModel();
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  void initState() {
    super.initState();
    sourcesViewModel.getSources(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => sourcesViewModel,
      child: Consumer<SourcesViewModel>(
        builder: (_, viewModel, __) {
          if (viewModel.isLoading) {
            return LoadingIndicator();
          } else if (viewModel.errorMessage != null) {
            return ErrorIndicator(viewModel.errorMessage!);
          } else {
            List<Source> sources = viewModel.sources;
            newsViewModel.getNews(viewModel.sources[currentIndex].id!);
            return Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: settingsProvider.isDark
                        ? AppTheme.white
                        : AppTheme.black,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsetsDirectional.only(start: 16),
                    tabs: sources
                        .map(
                          (source) => TabItem(
                            source: source,
                            isSelected: currentIndex == sources.indexOf(source),
                          ),
                        )
                        .toList(),
                    onTap: (index) {
                      if (currentIndex == index) return;
                      currentIndex = index;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: ChangeNotifierProvider.value(
                    value: newsViewModel,
                    child: Consumer<NewsViewModel>(
                      builder: (_, viewModel, _) {
                        if (viewModel.isLoading) {
                          return LoadingIndicator();
                        } else if (viewModel.errorMessage != null) {
                          return ErrorIndicator(viewModel.errorMessage!);
                        } else {
                          List<News> newsList = viewModel.newsList;
                          return ListView.separated(
                            padding: EdgeInsets.only(
                              top: 16,
                              right: 16,
                              left: 16,
                            ),
                            itemBuilder: (_, index) =>
                                NewsItem(newsList[index]),
                            separatorBuilder: (_, _) => SizedBox(height: 16),
                            itemCount: newsList.length,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
