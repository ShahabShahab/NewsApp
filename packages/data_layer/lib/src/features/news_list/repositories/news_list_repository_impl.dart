import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/features/news_list/data_sources/news_list_remote_data_source.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:domain_layer/domain_layer.dart';

class NewsListRepositoryImpl implements NewsRepository {
  final NewsListRemoteDataSource dataSource;

  NewsListRepositoryImpl({required this.dataSource});

  @override
  Future<Either<DomainFailure, List<Article>>> getTopHeadlinesUS() async {
    try {
      final List<ArticleModel> models =
          await dataSource.getTopHeadlinesUS(apiKey, 'US');
      final articles = models
          .map((element) => Article(
              title: element.title,
              description: element.description,
              url: element.url,
              content: element.content))
          .toList();
      return Right(value: articles);
    } on DioException {
      return Left(value: ServerFailure());
    }
  }
}
