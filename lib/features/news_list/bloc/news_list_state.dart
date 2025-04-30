part of 'news_list_bloc.dart';

sealed class NewsListState extends Equatable {
  const NewsListState();
}

final class NewsListInitial extends NewsListState {
  @override
  List<Object> get props => [];
}

final class NewsListLoading extends NewsListState {
  @override
  List<Object?> get props => [];
}

final class NewsListItemsLoaded extends NewsListState {
  final List<Article> articles;

  const NewsListItemsLoaded({required this.articles});

  @override
  List<Object?> get props => [articles];
}
