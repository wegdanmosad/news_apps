import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_apps/shared/api_constants.dart';
import 'package:news_apps/news/data/models/news_response.dart';
import 'package:news_apps/sources/data/models/sources_response.dart';

class ApiService {
  static Future getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstants.baseURL, ApiConstants.sourcesEndpoint, {
      'apiKey': ApiConstants.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }

  static Future getNews(String sourceId, {String? query}) async {
    Uri uri = Uri.https(ApiConstants.baseURL, ApiConstants.newsEndpoint, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      if (query != null && query.isNotEmpty) 'q': query,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}
