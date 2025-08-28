import 'package:flutter/material.dart';
import 'package:news_apps/api/api_service.dart';
import 'package:news_apps/app_theme.dart';
import 'package:news_apps/models/news_response/news.dart';
import 'package:news_apps/models/sources_response/source.dart';
import 'package:news_apps/news/news_item.dart';
import 'package:news_apps/news/tab_item.dart';
import 'package:news_apps/widget/error_indicator.dart';
import 'package:news_apps/widget/loading_indicator.dart';

class NewsView extends StatefulWidget {
  String categoryId;
  String searchQuery;

  NewsView({required this.categoryId, required this.searchQuery});
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  late var getSourcesFuture = ApiService.getSources(widget.categoryId);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSourcesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data?.status != 'ok') {
          return ErrorIndicator();
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];

          return Column(
            children: [
              DefaultTabController(
                length: sources.length,
                child: TabBar(
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorColor: AppTheme.white,
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
                child: FutureBuilder(
                  future: ApiService.getNews(
                    sources[currentIndex].id!,
                    query: widget.searchQuery.isEmpty
                        ? null
                        : widget.searchQuery,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingIndicator();
                    } else if (snapshot.hasError ||
                        snapshot.data?.status != 'ok') {
                      return ErrorIndicator();
                    } else {
                      List<News> newsList = snapshot.data?.newsList ?? [];
                      return ListView.separated(
                        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                        itemBuilder: (_, index) => NewsItem(newsList[index]),
                        separatorBuilder: (_, _) => SizedBox(height: 16),
                        itemCount: newsList.length,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
