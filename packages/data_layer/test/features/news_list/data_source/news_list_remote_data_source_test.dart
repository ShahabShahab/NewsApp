import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/features/news_list/data_sources/news_list_remote_data_source.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mock_dio.dart';

void main() {
  late MockDio mockDio;
  late NewsListRemoteDataSource newsListRemoteDataSource;
  late List tResponse;

  setUpAll(() {
    mockDio = MockDio();
    newsListRemoteDataSource = NewsListRemoteDataSource(mockDio);
    tResponse = [
      {
        'title': 'Title1',
        'description': 'Desc1',
        'url': 'http://url1.com',
        'urlToImage': 'http://img1.com',
        'publishedAt': '2025-04-28T12:00:00Z',
        'content': 'Content1'
      },
      {
        'title': 'Title2',
        'description': 'Desc2',
        'url': 'http://url2.com',
        'urlToImage': 'http://img2.com',
        'publishedAt': '2025-04-28T13:00:00Z',
        'content': 'Content2'
      },
    ];
  });

  // group("general scheme of dio functioning inside NewsListRemoteDataSource",
  //     () {
  //   test("should return List<ArticleModel> once the api returns 200 as code",
  //       () async {
  //     //arrange
  //     final response = Response(
  //       requestOptions: RequestOptions(path: '/top-headlines'),
  //       data: tResponse,
  //       statusCode: 200,
  //     );
  //
  //     when(() => mockDio.get("/top-headlines",
  //             queryParameters: {'apiKey': apiKey, 'country': "US"}))
  //         .thenAnswer((_) async => response);
  //
  //     //act
  //     final result =
  //         await newsListRemoteDataSource.getTopHeadlinesUS(apiKey, "US");
  //
  //     //assert
  //     verify(() => mockDio.get(
  //           '/top-headlines',
  //           queryParameters: {'apiKey': apiKey, 'country': "US"},
  //         )).called(1);
  //   });
  // });
}
