import 'package:news_apps/sources/data/models/source.dart';
import 'package:news_apps/sources/data/data_sources/sources_data_source.dart';

class SourcesFirebaseDataSource implements SourcesDataSource {
  @override
  Future<List<Source>> getSources(String categoryId) async {
    //
    return [];
  }
}
