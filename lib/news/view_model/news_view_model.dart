import 'package:flutter/widgets.dart';
import 'package:news_apps/news/data/data_sources/news_data_source.dart';
import 'package:news_apps/news/data/models/news.dart';
import 'package:news_apps/news/data/models/news_response.dart';

class NewsViewModel with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  NewsDataSource dataSource = NewsDataSource();
  List<News> newsList = [];
  Future<void> getNews(String sourceId) async {
    try {
      isLoading = true;
      NewsResponse response = await dataSource.getNews(sourceId);
      if (response.status == 'ok' && response.newsList != null) {
        newsList = response.newsList!;
      } else {
        errorMessage = 'Failed to load sources';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
