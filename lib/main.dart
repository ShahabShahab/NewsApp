import 'package:code_challenge_news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:code_challenge_news_app/features/news_list/pages/news_list_page.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_layer/injection_layer.dart';
import 'package:resourcing/resourcing.dart';

void main() {
  setUpDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: NewsFonts.mainFont,
          scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData(
          fontFamily: NewsFonts.mainFont,
          scaffoldBackgroundColor: Colors.white),
      themeMode: ThemeMode.light,
      home: BlocProvider(
        create: (_) =>
            NewsListBloc(GetTopHeadlinesUS(repo: resolve<NewsRepository>())),
        child: NewsListPage(),
      ),
    );
  }
}
