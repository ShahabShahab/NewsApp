import 'package:code_challenge_news_app/core/wigets/news_lottie.dart';
import 'package:code_challenge_news_app/core/wigets/news_text.dart';
import 'package:code_challenge_news_app/features/news_list/bloc/news_list_bloc.dart';
import 'package:code_challenge_news_app/features/news_list/pages/news_list_page.dart';
import 'package:code_challenge_news_app/features/splash/cubit/splash_cubit.dart';
import 'package:code_challenge_news_app/generated/assets.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_layer/injection_layer.dart';
import 'package:resourcing/resourcing.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is AppConfigLoaded) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (_) => NewsListCubit(
                            GetTopHeadlinesUS(repo: resolve<NewsRepository>())),
                        child: NewsListPage(),
                      )));
        }
      },
      child: Scaffold(
        body: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NewsLottie(
              asset: Assets.lottieSplash,
              height: 400,
            ),
            NewsText(
                text: "News API is loading...",
                style:
                    NewsTextStyles.heading1.copyWith(color: NewsColors.white))
          ],
        ),
      ),
    );
  }
}
