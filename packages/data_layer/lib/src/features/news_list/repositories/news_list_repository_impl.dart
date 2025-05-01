import 'dart:ui';

import 'package:data_layer/src/core/connectivity_service.dart';
import 'package:data_layer/src/features/news_list/data_sources/news_list_local_data_source.dart';
import 'package:data_layer/src/features/news_list/data_sources/news_list_remote_data_source.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:domain_layer/domain_layer.dart';

class NewsListRepositoryImpl implements NewsRepository {
  final NewsListRemoteDataSource remoteDataSource;
  final NewsListLocalDataSource localDataSource;
  final ConnectivityService connectivityService;

  NewsListRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.connectivityService});

  @override
  Future<Either<DomainFailure, List<Article>>> getTopHeadlinesUS(
      {required int page}) async {
    try {
      late List<Article> articles;
      bool hasNoConnection = await connectivityService.hasNoConnection();
      if (hasNoConnection) {
        final response = await localDataSource.getCachedArticles(page);
        if (response.isEmpty) {
          return Right(value: []);
        }
        articles = _convertArticleModelsToArticleEntities(response);
      } else {
        final response = await _fetchArticlesFromRemote(page);
        if (page == 1) {
          await localDataSource.cacheArticles(response);
        } else {
          await localDataSource.addArticles(response);
        }
        articles = _convertArticleModelsToArticleEntities(response);
      }
      return Right(value: articles);
    } on DioException catch (e) {
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
