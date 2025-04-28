import 'package:data_layer/src/core/http_client.dart';
import 'package:data_layer/src/features/news_list/data_sources/news_list_remote_data_source.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:data_layer/src/features/news_list/repositories/news_list_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';

import '../../mocks/mock_news_list_remote_data_source.dart';

void main() {
  late NewsListRepositoryImpl newsListRepositoryImpl;
  late NewsListRemoteDataSource mockNewsListRemoteDataSource;

  final tModels = <ArticleModel>[
    ArticleModel(
      title: 'Google loses adtech monopoly case',
      description:
          'The US Department of Justice has won its antitrust case against Google, which accused the company of operating a monopoly in the advertising technology industry. In a ruling on Thursday, US District Judge Leonie Brinkema says Google’s anticompetitive practice',
      url:
          "https://www.theverge.com/news/650665/google-loses-ad-tech-antitrust-monopoly-lawsuit",
      urlToImage:
          'https://platform.theverge.com/wp-content/uploads/sites/2/2025/04/STKS487_ANTITRUST_2__STK093_GOOGLE.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200',
      publishedAt: DateTime.parse('2025-04-28T12:00:00Z'),
      content: 'C1',
    ),
    ArticleModel(
      title: 'Google is fixing outdated Pixel weather forecasts',
      description:
          'Some Google Pixel users have found that their At a Glance widget has been showing outdated weather forecasts, as reported by Android Police. But the company says in a statement to The Verge that it’s addressing the issue. According to one user on Reddit who...',
      url:
          'https://www.theverge.com/news/641127/google-pixel-weather-forecasts-bug',
      urlToImage:
          'https://platform.theverge.com/wp-content/uploads/sites/2/2025/04/DSC08087.jpg.webp?quality=90&strip=all&crop=0,15.095986038394,100,69.808027923211',
      publishedAt: DateTime.parse('2025-04-28T13:00:00Z'),
      content: 'C2',
    ),
  ];

  setUpAll(() {
    mockNewsListRemoteDataSource =
        NewsListRemoteDataSource(HttpClient.getInstance());
    newsListRepositoryImpl = NewsListRepositoryImpl(
        dataSource: NewsListRemoteDataSource(HttpClient.getInstance()));
  });

  group("NewsListRepositoryImpl tests", () {
    test(
        "should return a list of Articles once the datasource completes successfully",
        () async {
      //arrange

      when(() => mockNewsListRemoteDataSource.getTopHeadlinesUS("", ""))
          .thenAnswer((_) async => tModels);

      //act
      final result = await newsListRepositoryImpl.getTopHeadlinesUS();

      //assert
      verify(() => mockNewsListRemoteDataSource).called(1);
    });
  });
}
