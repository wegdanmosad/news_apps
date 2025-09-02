import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_apps/api/api_constants.dart';
import 'package:news_apps/sources/data/models/sources_response.dart';

class SourcesDataSource {
  Future getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstants.baseURL, ApiConstants.sourcesEndpoint, {
      'apiKey': ApiConstants.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }
}
