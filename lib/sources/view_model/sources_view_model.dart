import 'package:flutter/material.dart';
import 'package:news_apps/shared/service_locator.dart';
import 'package:news_apps/sources/data/models/source.dart';
import 'package:news_apps/sources/data/repositories/sources_repository.dart';

class SourcesViewModel with ChangeNotifier {
  late SourcesRepository repository;
  List<Source> sources = [];
  bool isLoading = false;
  String? errorMessage;
  SourcesViewModel() {
    repository = SourcesRepository(ServiceLocator.sourcesDataSource);
  }
  Future<void> getSources(String categoryId) async {
    try {
      isLoading = true;
      sources = (await repository.getSources(categoryId)).cast<Source>();
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
