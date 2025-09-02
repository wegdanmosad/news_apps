import 'package:flutter/widgets.dart';
import 'package:news_apps/news/data/data_sources/news_data_source.dart';
import 'package:news_apps/news/data/models/news.dart';
import 'package:news_apps/news/data/repositories/news_repository.dart';
import 'package:news_apps/shared/service_locator.dart';

class NewsViewModel with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  late NewsRepository repository;
  List<News> newsList = [];
  NewsViewModel() {
    repository = NewsRepository(ServiceLocator.newsDataSource);
  }
  Future<void> getNews(String sourceId) async {
    try {
      isLoading = true;
      newsList = await repository.getNews(sourceId);
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
