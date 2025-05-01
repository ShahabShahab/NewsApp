import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String description;
  final String url;
  final String content;

  const Article(
      {required this.title,
      required this.description,
      required this.url,
      required this.content});

  @override
  List<Object?> get props => [title, description, url, content];

  Article copyWith(
      {String? title, String? description, String? url, String? content}) {
    return Article(
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        content: content ?? this.content);
  }
}
