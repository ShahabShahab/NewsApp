part of 'news_list_bloc.dart';

sealed class NewsListEvent extends Equatable {
  const NewsListEvent();
}

final class FetchHeadLinesEvent extends NewsListEvent {
  @override
  List<Object?> get props => [];
}
