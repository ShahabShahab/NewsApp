import 'package:data_layer/src/core/constants.dart';
import 'package:data_layer/src/features/news_list/repositories/news_list_repository_impl.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

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
    setUp(() {
      when(() => mockConnectivityService.hasNoConnection())
          .thenAnswer((_) async => true);
    });
    test(
        "Connection is not established and the disk has no already save articles",
        () async {
      //arrange

      when(() => mockLocalDataSource.getCachedArticles(1,
          pageSize: any(named: "pageSize"))).thenAnswer((_) async => []);

      //act
      final result = await repositoryImpl.getTopHeadlinesUS(page: 1);
      //assert
      expect(
          result,
          equals(Left(
              value: ServerFailure(message: notConnectedToTheInternetError))));

      verifyInOrder([
        () => mockConnectivityService.hasNoConnection(),
        () => mockLocalDataSource.getCachedArticles(1)
      ]);
      verifyNoMoreInteractions(mockConnectivityService);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
    });
  });
}
