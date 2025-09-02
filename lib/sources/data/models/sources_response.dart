import 'package:news_apps/sources/data/models/source.dart';

class SourcesResponse {
  final String? status;
  final List<Source>? sources;

  SourcesResponse({this.status, this.sources});

  factory SourcesResponse.fromJson(Map<String, dynamic> json) {
    return SourcesResponse(
      status: json['status'],
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => Source.fromJson(e))
          .toList(),
    );
  }
}
