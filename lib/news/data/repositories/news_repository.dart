import 'package:news_apps/news/data/data_sources/news_data_source.dart';
import 'package:news_apps/news/data/models/news.dart';

class NewsRepository {
  NewsDataSource dataSource;

  NewsRepository(this.dataSource);
  Future<List<News>> getNews(String sourceId, {String? query}) async {
    return dataSource.getNews(sourceId);
  }
}
