import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String query;
  final String title;
  final String description;
  final String url;
  final String content;
  final String? urlToImage;
  final DateTime? publishedAt;
  final Source? source;

  const Article(
      {required this.query,
      required this.title,
      required this.description,
      required this.url,
      required this.content,
      this.publishedAt,
      this.urlToImage,
      this.source});

  @override
  List<Object?> get props => [title, description, url, content];

  Article copyWith({
    String? query,
    String? title,
    String? description,
    String? url,
    String? content,
    DateTime? publishedAt,
    String? urlToImage,
    Source? source,
  }) {
    return Article(
      query: query ?? this.query,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      content: content ?? this.content,
      publishedAt: publishedAt ?? this.publishedAt,
      urlToImage: urlToImage ?? this.urlToImage,
      source: source ?? this.source,
    );
  }
}

class Source {
  Source({
    this.id,
    this.name,
  });

  String? id;
  String? name;
}
