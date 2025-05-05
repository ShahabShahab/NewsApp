import 'package:data_layer/src/core/constants.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:data_layer/src/features/news_list/models/get_top_headline_response.dart';
import 'package:data_layer/src/features/news_list/repositories/news_list_repository_impl.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../utils/utils.dart';
import '../../mocks/mock_news_list_remote_data_source.dart';

void main() {
  late NewsListRepositoryImpl repositoryImpl;
  late MockNewsListRemoteDataSource mockRemoteDataSource;
  late MockNewsListLocalDataSource mockLocalDataSource;
  late MockConnectivityService mockConnectivityService;

  setUpAll(() {
    mockLocalDataSource = MockNewsListLocalDataSource();
    mockRemoteDataSource = MockNewsListRemoteDataSource();
    mockConnectivityService = MockConnectivityService();
    repositoryImpl = NewsListRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        connectivityService: mockConnectivityService);
  });

  group("getTopHeadlinesUS once the connection is not established", () {
    late List<ArticleModel> tAlreadySavedArticles;
    setUp(() {
      when(() => mockConnectivityService.hasNoConnection())
          .thenAnswer((_) async => true);
    });
    test("the disk has no already save articles", () async {
      //arrange

      when(() => mockLocalDataSource.getCachedArticles(1,
          pageSize: any(named: "pageSize"))).thenAnswer((_) async => []);

      //act
      final result = await repositoryImpl.getTopHeadlinesUS(page: 1);
      //assert
      expect(
          result,
          equals(Left<DomainFailure, List<Article>>(
              value: ServerFailure(message: notConnectedToTheInternetError))));

      _verifyOnceThereIsNoConnection(
          mockConnectivityService, mockLocalDataSource, mockRemoteDataSource);
    });

    test("the disk has some already saved news on the disk", () async {
      //arrange
      late List<ArticleModel> tArticleModels;
      late List<Article> tArticles;
      tArticleModels = createTestArticleModels();
      tArticles = createTestArticlesBasedOnArticleModels(tArticleModels);
      when(() => mockLocalDataSource.getCachedArticles(any(),
              pageSize: any(named: "pageSize")))
          .thenAnswer((_) async => tArticleModels);
      //act

      final result = await repositoryImpl.getTopHeadlinesUS(page: 1);

      //assert
      expect(result, Right<DomainFailure, List<Article>>(value: tArticles));
      _verifyOnceThereIsNoConnection(
          mockConnectivityService, mockLocalDataSource, mockRemoteDataSource);
    });

    test("the disk data has reached to the end", () async {
      // arrange
      when(() => mockLocalDataSource.getCachedArticles(any(),
              pageSize: any(named: "pageSize")))
          .thenThrow(offlineFirstListHasAlreadyEndedErrorMessage);

      final expected = Left<DomainFailure, List<Article>>(
        value:
            ServerFailure(message: offlineFirstListHasAlreadyEndedErrorMessage),
      );

      // act
      final result = await repositoryImpl.getTopHeadlinesUS(page: 3);
      expect(result, equals(expected));
      _verifyOnceThereIsNoConnection(
          mockConnectivityService, mockLocalDataSource, mockRemoteDataSource);
    });
  });

  group("getTopHeadlinesUS() once the connection is established", () {
    setUp(() {
      when(() => mockConnectivityService.hasNoConnection())
          .thenAnswer((_) async => false);
    });
    test("Once the remote data source works fine and returns 200 status code",
        () async {
      //arrange
      final tPageNumber = 1;
      final tResponse = createGetTopHeadlineResponse();
      when(() => mockRemoteDataSource.getTopHeadlinesUS(
              any(), any(), any(), any(), any(), any(), any(), any()))
          .thenAnswer((_) async => tResponse);
      when(() => mockLocalDataSource.cacheArticles(any()))
          .thenAnswer((_) async => Future.value(true));

      //act

      final result = await repositoryImpl.getTopHeadlinesUS(page: tPageNumber);

      //assert
      final capture = verify(() => mockRemoteDataSource.getTopHeadlinesUS(
          any(), any(), any(), any(), any(), any(), any(), any())).captured;
      expect(
          result,
          equals(Right<DomainFailure, List<Article>>(
              value: repositoryImpl.convertArticleModelsToArticleEntities(
                  tResponse.articles!))));
    });
  });
}

void _verifyOnceThereIsNoConnection(
    MockConnectivityService mockConnectivityService,
    MockNewsListLocalDataSource mockLocalDataSource,
    MockNewsListRemoteDataSource mockRemoteDataSource) {
  verifyInOrder([
    () => mockConnectivityService.hasNoConnection(),
    () => mockLocalDataSource.getCachedArticles(any(),
        pageSize: any(named: "pageSize")),
  ]);
  verifyZeroInteractions(mockRemoteDataSource);
  verifyNever(() => mockLocalDataSource.cacheArticles(any()));
  verifyNever(() => mockLocalDataSource.addArticles(any()));
  verifyNoMoreInteractions(mockConnectivityService);
  verifyNoMoreInteractions(mockLocalDataSource);
}
