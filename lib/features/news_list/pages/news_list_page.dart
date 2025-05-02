import 'package:code_challenge_news_app/core/wigets/news_lottie.dart';
import 'package:code_challenge_news_app/features/news_details/page/news_details_page.dart';
import 'package:code_challenge_news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:code_challenge_news_app/features/news_list/widgets/news_list_item_row.dart';
import 'package:code_challenge_news_app/generated/assets.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:resourcing/resourcing.dart';

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
        backgroundColor: NewsColors.primary.shade900,
        appBar: AppBar(
          title: const Text("Top Headlines"),
          backgroundColor: NewsColors.gray.shade300,
        ),
        body: BlocBuilder<NewsListCubit, PagingState<int, Article>>(
            builder: (context, state) {
          return PagedListView<int, Article>(
            state: state,
            fetchNextPage: () {
              BlocProvider.of<NewsListCubit>(context).fetchHeadlines();
            },
            builderDelegate: PagedChildBuilderDelegate<Article>(
                itemBuilder: (context, article, index) => Column(
                      children: [
                        NewsListItemRow(
                            article: article,
                            onArticleTap: (article) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewsDetailPage(article: article)))),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                firstPageProgressIndicatorBuilder: (context) {
                  return Center(
                    child: SizedBox(
                      child: NewsLottie(
                        asset: Assets.lottieSplash,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  );
                },
                newPageProgressIndicatorBuilder: (context) {
                  return Column(
                    children: [
                      NewsLottie(
                        asset: Assets.lottieSplash,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }),
          );
        }));
  }
}
