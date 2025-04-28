import 'package:code_challenge_news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(
            Duration(seconds: 1),
            () => BlocProvider.of<NewsListBloc>(context)
                .add(FetchHeadLinesEvent())),
        builder: (context, snapshot) {
          return Placeholder();
        });
  }
}
