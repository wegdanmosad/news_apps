import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_apps/news/view_model/news_states.dart';
import 'package:news_apps/shared/app_theme.dart';
import 'package:news_apps/home/view/widgets/drawer/settings_provider.dart';
import 'package:news_apps/news/data/models/news.dart';
import 'package:news_apps/sources/data/models/source.dart';
import 'package:news_apps/news/view_model/news_view_model.dart';
import 'package:news_apps/news/view/widgets/news_item.dart';
import 'package:news_apps/sources/view/widgets/tab_item.dart';
import 'package:news_apps/sources/view_model/source_states.dart';
import 'package:news_apps/sources/view_model/sources_view_model.dart';
import 'package:news_apps/shared/widget/error_indicator.dart';
import 'package:news_apps/shared/widget/loading_indicator.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  String categoryId;
  String searchQuery;

  NewsView({required this.categoryId, required this.searchQuery});
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  SourcesViewModel sourcesViewModel = SourcesViewModel();
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  void initState() {
    super.initState();
    sourcesViewModel.getSources(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return BlocProvider(
      create: (_) => sourcesViewModel,
      child: BlocBuilder<SourcesViewModel,SourceStates>(
        builder: (context, state) {
           BlocProvider.of<SourcesViewModel>(context);
          if (state is GetSourcesLoading) {
            return LoadingIndicator();
          } else if (state is GetSourcesError) {
            return ErrorIndicator(state.massegae);
          } else if(state is GetSourcesSuccess) {
            List<Source> sources = state.sources.cast<Source>();
            newsViewModel.getNews(state.sources[currentIndex].id!);
            return Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: settingsProvider.isDark
                        ? AppTheme.white
                        : AppTheme.black,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsetsDirectional.only(start: 16),
                    tabs: sources
                        .map(
                          (source) => TabItem(
                            source: source,
                            isSelected: currentIndex == sources.indexOf(source),
                          ),
                        )
                        .toList(),
                    onTap: (index) {
                      if (currentIndex == index) return;
                      currentIndex = index;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: BlocProvider(
                    create:(_)=> newsViewModel,
                    child: BlocBuilder<NewsViewModel,NewsStates>(
                      builder: (_,state) {
                        if (state is GetNewsLoading) {
                          return LoadingIndicator();
                        } else if (state is GetNewsError) {
                          return ErrorIndicator(state.massegae);
                        } else if(state is GetNewsSuccess){
                          List<News> newsList = state.newsList;
                          return ListView.separated(
                            padding: EdgeInsets.only(
                              top: 16,
                              right: 16,
                              left: 16,
                            ),
                            itemBuilder: (_, index) =>
                                NewsItem(newsList[index]),
                            separatorBuilder: (_, _) => SizedBox(height: 16),
                            itemCount: newsList.length,
                          );
                        }else{
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }else{
            return SizedBox();
          }
        },
      ),
    );
  }
}
