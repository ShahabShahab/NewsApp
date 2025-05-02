// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_top_headline_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTopHeadlineResponse _$GetTopHeadlineResponseFromJson(
        Map<String, dynamic> json) =>
    GetTopHeadlineResponse(
      status: json['status'] as String?,
      totalResults: (json['totalResults'] as num?)?.toInt(),
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTopHeadlineResponseToJson(
        GetTopHeadlineResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };
