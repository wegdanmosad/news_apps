import 'package:news_apps/sources/data/models/source.dart';

abstract class SourcesDataSource {
  Future<List<Source>> getSources(String categoryId);
}
