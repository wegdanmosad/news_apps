import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_apps/shared/api_constants.dart';
import 'package:news_apps/sources/data/models/source.dart';
import 'package:news_apps/sources/data/models/sources_response.dart';
import 'package:news_apps/sources/data/data_sources/sources_data_source.dart';

class SourcesAPIDataSource implements SourcesDataSource {
  @override
  Future<List<Source>> getSources(String categoryId) async {
    final uri = Uri.https(ApiConstants.baseURL, ApiConstants.sourcesEndpoint, {
      'apiKey': ApiConstants.apiKey,
      'category': categoryId,
    });

    final response = await http.get(uri);
    final Map<String, dynamic> json = jsonDecode(response.body);
    final sourcesResponse = SourcesResponse.fromJson(json);

    if (sourcesResponse.status == 'ok' && sourcesResponse.sources != null) {
      return sourcesResponse.sources!;
    } else {
      throw Exception('Failed to get sources');
    }
  }
}
