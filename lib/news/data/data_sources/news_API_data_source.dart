import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_apps/shared/api_constants.dart';
import 'package:news_apps/news/data/data_sources/news_data_source.dart';
import 'package:news_apps/news/data/models/news.dart';
import 'package:news_apps/news/data/models/news_response.dart';

class NewsAPIDataSource implements NewsDataSource {
  Future<List<News>> getNews(String sourceId, {String? query}) async {
    Uri uri = Uri.https(ApiConstants.baseURL, ApiConstants.newsEndpoint, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      if (query != null && query.isNotEmpty) 'q': query,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    if (newsResponse.status == 'ok' && newsResponse.newsList != null) {
      return newsResponse.newsList!;
    } else {
      throw Exception('Failed to get news');
    }
  }
}
