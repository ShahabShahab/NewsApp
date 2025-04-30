import 'package:code_challenge_news_app/core/logging/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_layer/domain_layer.dart';

part 'news_list_event.dart';

part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  final GetTopHeadlinesUS getTopHeadlinesUS;

  NewsListBloc(this.getTopHeadlinesUS) : super(NewsListInitial()) {
    on<NewsListEvent>((event, emit) async {
      if (event is FetchHeadLinesEvent) {
        emit(NewsListLoading());
        final result = await getTopHeadlinesUS.call();
        result.fold((error) {
          Logger.error("Error message: $error");
        }, (data) {
          Logger.info("Info message: ${data.length}");
          emit(NewsListItemsLoaded(articles: data));
        });
      }
    });
  }
}
