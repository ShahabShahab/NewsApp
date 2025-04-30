import 'package:code_challenge_news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:code_challenge_news_app/features/news_list/widgets/news_list_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsListBloc>().add(FetchHeadLinesEvent());
    });
    return BlocBuilder<NewsListBloc, NewsListState>(builder: (context, state) {
      if (state is NewsListLoading) {
        return CircularProgressIndicator();
      } else if (state is NewsListItemsLoaded) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 10,
                  children: [
                    NewsListItemRow(article: state.articles[index]),
                  ],
                ),
              );
            },
            itemCount: state.articles.length,
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
