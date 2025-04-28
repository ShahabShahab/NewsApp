import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'news_list_remote_data_source.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2')
abstract class NewsListRemoteDataSource {
  factory NewsListRemoteDataSource(Dio dio, {String? baseUrl}) =
      _NewsListRemoteDataSource;

  @GET('/top-headlines')
  Future<List<ArticleModel>> getTopHeadlinesUS(
    @Query('apiKey') String apiKey,
    @Query('country') String country,
  );
}
