import 'dart:ui';

import 'package:data_layer/src/core/connectivity_service.dart';
import 'package:data_layer/src/core/constants.dart';
import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/core/server_error.dart';
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
      final error = ServerError.fromJson(e.response as Map<String, String>);
      return Left(value: ServerFailure(message: error.message));
    } catch (e) {
      return Left(value: ServerFailure(message: e.toString()));
    }
  }

  List<Article> _convertArticleModelsToArticleEntities(
      List<ArticleModel> articleModels) {
    return articleModels
        .map((element) => Article(
              publishedAt: element.publishedAt,
              sourceName: element.source?.name,
              author: element.author,
              query: element.query ?? "",
              title: element.title ?? "",
              description: element.description ?? "",
              url: element.url ?? "",
              urlToImage: element.urlToImage,
              content: element.content ?? "",
            ))
        .toList();
  }

  Future<List<ArticleModel>> _fetchArticlesFromRemote(int page) async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final fromDate = yesterday.toString().split(" ")[0];
    final toDate = now.toString().split(" ")[0];
    final queries = ['Microsoft', 'Apple', 'Google', 'Tesla'];
    final List<ArticleModel> allArticles = [];
    for (final q in queries) {
      final result = await remoteDataSource.getTopHeadlinesUS(
        apiKey,
        page,
        pageSize,
        q,
        fromDate,
        toDate,
        'en',
      );
      allArticles.addAll(result.articles!
          .map((element) => element.copyWith(
              title: element.title,
              description: element.description,
              url: element.url,
              urlToImage: element.urlToImage,
              publishedAt: element.publishedAt,
              content: element.content,
              source: element.source,
              author: element.author,
              query: q))
          .toList());
    }
    return allArticles;
  }
}
