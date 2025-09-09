import 'package:news_apps/sources/data/models/source.dart';

abstract class SourceStates{

}
class SourcesIntial extends SourceStates{}

class GetSourcesLoading extends SourceStates{}

class GetSourcesSuccess extends SourceStates{
  List<Source> sources ;
  GetSourcesSuccess(this.sources);
}
class GetSourcesError extends SourceStates{
  String massegae;
  GetSourcesError (this.massegae);
}