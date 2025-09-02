import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_apps/api/api_constants.dart';
import 'package:news_apps/news/data/models/news_response.dart';

class NewsDataSource {
  Future getNews(String sourceId, {String? query}) async {
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
