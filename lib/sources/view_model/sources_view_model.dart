import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apps/shared/service_locator.dart';
import 'package:news_apps/sources/data/models/source.dart';
import 'package:news_apps/sources/data/repositories/sources_repository.dart';
import 'package:news_apps/sources/view_model/source_states.dart';

class SourcesViewModel extends Cubit<SourceStates> {
  late SourcesRepository repository;
  
  SourcesViewModel():super(SourcesIntial()) {
    repository = SourcesRepository(ServiceLocator.sourcesDataSource);
  }
  Future<void> getSources(String categoryId) async {
    try {
      emit(GetSourcesLoading());
      List<Source> sources = (await repository.getSources(categoryId)).cast<Source>();
      emit(GetSourcesSuccess(sources));
    } catch (error) {
      emit(GetSourcesError(error.toString()));
    }
  }
}
