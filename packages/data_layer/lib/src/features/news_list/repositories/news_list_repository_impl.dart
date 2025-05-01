import 'package:data_layer/src/features/news_list/data_sources/news_list_local_data_source.dart';
import 'package:data_layer/src/features/news_list/data_sources/news_list_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:domain_layer/domain_layer.dart';

class NewsListRepositoryImpl implements NewsRepository {
  final NewsListRemoteDataSource dataSource;

  NewsListRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DomainFailure, List<Article>>> getTopHeadlinesUS(
      {required int page}) async {
    try {
      final response = await dataSource.getTopHeadlinesUS(page);
      final articleLocalDataSource = ArticleLocalDataSource();
      final lastSyncTime = await articleLocalDataSource.fetchSyncTime();
      if (lastSyncTime != null) {

      } else {
        await articleLocalDataSource.saveSyncTime(DateTime.now());
        final lastSyncTime = await articleLocalDataSource.fetchSyncTime();
        print('NewsListRepositoryImpl.getTopHeadlinesUS $lastSyncTime');
      }
      final articles = response.articles!
          .map((element) => Article(
              title: element.title,
              description: element.description,
              url: element.urlToImage,
              content: element.content))
          .toList();
      return Right(value: articles);
    } on DioException catch (e) {
      return Left(value: ServerFailure());
    }
  }
}
