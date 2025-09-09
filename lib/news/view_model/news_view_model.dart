import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apps/news/data/models/news.dart';
import 'package:news_apps/news/data/repositories/news_repository.dart';
import 'package:news_apps/news/view_model/news_states.dart';
import 'package:news_apps/shared/service_locator.dart';

class NewsViewModel extends Cubit<NewsStates> {
  late NewsRepository repository;
  NewsViewModel() :super(NewsIntial()){
    repository = NewsRepository(ServiceLocator.newsDataSource);
  }
  Future<void> getNews(String sourceId) async {
    try {
      emit(GetNewsLoading());
      List<News>  newsList = await repository.getNews(sourceId);
      emit(GetNewsSuccess(newsList));
    } catch (error) {
      emit(GetNewsError(error.toString()));
    }
  }
}
