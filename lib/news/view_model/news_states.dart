
import 'package:news_apps/news/data/models/news.dart';

abstract class NewsStates{

}
class NewsIntial extends NewsStates{}

class GetNewsLoading extends NewsStates{}

class GetNewsSuccess extends NewsStates{
  List<News> newsList ;
  GetNewsSuccess(this.newsList);
}
class GetNewsError extends NewsStates{
  String massegae;
  GetNewsError (this.massegae);
}