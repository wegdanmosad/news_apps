import 'package:news_apps/news/data/data_sources/news_data_source.dart';
import 'package:news_apps/news/data/models/news.dart';

class NewsFirebaseDataSource implements NewsDataSource {
  @override
  Future<List<News>> getNews(String sourceId, {String? query}) async {
    return [];
  }
}
