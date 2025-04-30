import 'package:code_challenge_news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:code_challenge_news_app/features/news_list/widgets/news_list_item_row.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<NewsListCubit>(context).fetchHeadlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Top Headlines")),
        body: BlocBuilder<NewsListCubit, PagingState<int, Article>>(
            builder: (context, state) {
          return PagedListView<int, Article>(
            state: state,
            fetchNextPage: () {
              BlocProvider.of<NewsListCubit>(context).fetchHeadlines();
            },
            builderDelegate: PagedChildBuilderDelegate<Article>(
              itemBuilder: (context, article, index) =>
                  NewsListItemRow(article: article),
            ),
          );
        }));
  }
}
