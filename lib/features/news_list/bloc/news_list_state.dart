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
  final bool isLastPage;

  const NewsListItemsLoaded({
    required this.articles,
    required this.isLastPage,
  });

  @override
  List<Object?> get props => [articles, isLastPage];
}

