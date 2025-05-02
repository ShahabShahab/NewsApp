import 'package:data_layer/src/core/local_data_base_type_ids.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@HiveType(typeId: articleTypeID)
@JsonSerializable()
class ArticleModel {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String? url;
  @HiveField(5)
  final String? content;
  @HiveField(3)
  final String? urlToImage;
  @HiveField(4)
  final DateTime? publishedAt;
  @HiveField(6)
  final Source? source;
  @HiveField(7)
  final String? query;

  ArticleModel(
      {required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
      required this.source,
      required this.query});

  ArticleModel copyWith({
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
    Source? source,
    String? query,
  }) {
    return ArticleModel(
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      source: source ?? this.source,
      query: query ?? this.query,
    );
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

/// id : "the-verge"
/// name : "The Verge"

@HiveType(typeId: articleSourceTypeID)
@JsonSerializable()
class Source {
  Source({
    this.id,
    this.name,
  });

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
