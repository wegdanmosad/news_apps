import 'package:flutter/material.dart';
import 'package:news_apps/sources/data/data_sources/sources_data_source.dart';
import 'package:news_apps/sources/data/models/sources_response.dart';
import 'package:news_apps/sources/data/models/source.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesDataSource dataSource = SourcesDataSource();
  List<Source> sources = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getSources(String categoryId) async {
    try {
      isLoading = true;
      SourcesResponse response = await dataSource.getSources(categoryId);
      if (response.status == 'ok' && response.sources != null) {
        sources = response.sources!;
      } else {
        errorMessage = 'Failed to load sources';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
