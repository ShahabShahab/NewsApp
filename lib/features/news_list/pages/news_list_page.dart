import 'package:code_challenge_news_app/core/logging/logger.dart';
import 'package:code_challenge_news_app/core/wigets/news_lottie.dart';
import 'package:code_challenge_news_app/core/wigets/news_new_page_error_indicator.dart';
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
  Article? selectedArticle;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<NewsListCubit>(context).fetchHeadlines();
    });
  }

  bool get isTablet => MediaQuery.of(context).size.width >= 600;

  void _fetchHeadlines(){
    BlocProvider.of<NewsListCubit>(context).fetchHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    Logger.info("Width of the tablet: ${MediaQuery.of(context).size.width}");
    return Scaffold(
      backgroundColor: NewsColors.primary.shade900,
      appBar: AppBar(
        title: const Text("Top Headlines"),
        backgroundColor: NewsColors.gray.shade300,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: BlocBuilder<NewsListCubit, PagingState<int, Article>>(
              builder: (context, state) {
                return PagedListView<int, Article>(
                  state: state,
                  fetchNextPage: () {
                    _fetchHeadlines();
                  },
                  builderDelegate: PagedChildBuilderDelegate<Article>(
                    itemBuilder: (context, article, index) => Column(
                      children: [
                        NewsListItemRow(
                          article: article,
                          onArticleTap: (Article article) {
                            if (isTablet) {
                              setState(() {
                                if (selectedArticle != null &&
                                    article.title == selectedArticle!.title) {
                                  selectedArticle = null;
                                } else{
                                  selectedArticle = article;
                                }
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NewsDetailPage(article: article),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: NewsLottie(
                        asset: Assets.lottieSplash,
                        width: 200,
                        height: 200,
                      ),
                    ),
                    newPageProgressIndicatorBuilder: (_) => Column(
                      children: [
                        NewsLottie(
                          asset: Assets.lottieSplash,
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    firstPageErrorIndicatorBuilder: (context) =>  NewsNewPageErrorIndicator(message: state.error.toString(),
                    onTap: ()=> _fetchHeadlines(),),
                    newPageErrorIndicatorBuilder: (context) =>  NewsNewPageErrorIndicator(message: state.error.toString(),
                    onTap: () => _fetchHeadlines(),)
                  ),
                );
              },
            ),
          ),
          if (isTablet && selectedArticle != null)
            Expanded(
              flex: 3,
              child: selectedArticle == null
                  ? Center(
                      child: Text(
                        "Select an article",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  : NewsDetailPage(article: selectedArticle!),
            ),
        ],
      ),
    );
  }
}
