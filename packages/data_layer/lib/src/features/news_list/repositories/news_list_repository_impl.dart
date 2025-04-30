import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/features/news_list/data_sources/news_list_local_data_source.dart';
import 'package:data_layer/src/features/news_list/data_sources/news_list_remote_data_source.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:hive/hive.dart';

class NewsListRepositoryImpl implements NewsRepository {
  final NewsListRemoteDataSource dataSource;

  NewsListRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DomainFailure, List<Article>>> getTopHeadlinesUS(
      {required int page}) async {
    try {
      final response = await dataSource.getTopHeadlinesUS(page);
      ArticleLocalDataSource().addArticles(models);
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
