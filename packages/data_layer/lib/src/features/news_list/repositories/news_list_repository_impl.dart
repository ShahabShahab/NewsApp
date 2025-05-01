import 'package:data_layer/src/features/news_list/data_sources/news_list_local_data_source.dart';
import 'package:data_layer/src/features/news_list/data_sources/news_list_remote_data_source.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:domain_layer/domain_layer.dart';

class NewsListRepositoryImpl implements NewsRepository {
  final NewsListRemoteDataSource remoteDataSource;
  final NewsListLocalDataSource localDataSource;

  NewsListRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<DomainFailure, List<Article>>> getTopHeadlinesUS(
      {required int page}) async {
    try {
      final lastSyncTime = await localDataSource.fetchSyncTime();
      late List<Article> articles;
      if (lastSyncTime != null) {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - lastSyncTime > 1 * 60 * 1000) {
          final response = await _fetchArticlesFromRemote(page);
          await localDataSource.saveSyncTime();
          await localDataSource.cacheArticles(response);
          articles = _convertArticleModelsToArticleEntities(response);
        } else {
          final response = await localDataSource.getCachedArticles();
          articles = _convertArticleModelsToArticleEntities(response);
        }
      } else {
        final response = await _fetchArticlesFromRemote(page);
        await localDataSource.saveSyncTime();
        await localDataSource.cacheArticles(response);
        articles = _convertArticleModelsToArticleEntities(response);
      }
      return Right(value: articles);
    } on DioException catch (e, s) {
      return Left(value: ServerFailure());
    } catch (e) {
      print(e.toString());
      return Left(value: ServerFailure());
    }
  }

  List<Article> _convertArticleModelsToArticleEntities(
      List<ArticleModel> articleModels) {
    return articleModels
        .map((element) => Article(
            title: element.title,
            description: element.description,
            url: element.urlToImage,
            content: element.content))
        .toList();
  }

  Future<List<ArticleModel>> _fetchArticlesFromRemote(int page) async {
    final response = await remoteDataSource.getTopHeadlinesUS(page);

    return response.articles!;
  }
}
