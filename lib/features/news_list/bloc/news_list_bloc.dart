import 'package:code_challenge_news_app/core/logging/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'news_list_state.dart';

class NewsListCubit extends Cubit<PagingState<int, Article>> {
  final GetTopHeadlinesUS _getTopHeadlinesUS;

  NewsListCubit(this._getTopHeadlinesUS) : super(PagingState<int, Article>());

  Future<void> fetchHeadlines() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final newKey = (state.keys?.last ?? 0) + 1;
      final newItems = await _getTopHeadlinesUS.call(page: newKey);
      newItems.fold((failure) {
        emit(state.copyWith(
          error: failure,
          isLoading: false,
        ));
      }, (data) {
        final isLastPage = data.isEmpty;
        emit(state.copyWith(
          pages: [...?state.pages, data],
          keys: [...?state.keys, newKey],
          hasNextPage: !isLastPage,
          isLoading: false,
        ));
      });
    } catch (error) {
      emit(state.copyWith(
        error: error,
        isLoading: false,
      ));
    }
  }
}
