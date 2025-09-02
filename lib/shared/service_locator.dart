import 'package:news_apps/news/data/data_sources/news_API_data_source.dart';
import 'package:news_apps/news/data/data_sources/news_data_source.dart';
import 'package:news_apps/sources/data/data_sources/sources_API_data_source.dart';
import 'package:news_apps/sources/data/data_sources/sources_data_source.dart';

class ServiceLocator {
  static SourcesDataSource sourcesDataSource = SourcesAPIDataSource();
  static NewsDataSource newsDataSource = NewsAPIDataSource();
}
