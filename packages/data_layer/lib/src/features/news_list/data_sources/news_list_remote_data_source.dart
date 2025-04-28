import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'news_list_remote_data_source.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2/')
abstract class NewsListRemoteDataSource {
  factory NewsListRemoteDataSource(Dio dio, {String? baseUrl}) =
      _NewsListRemoteDataSource;

  @GET(
      '/everything?q=microsoft&from=???&to=???&sortBy=???%20&page=1&pageSize=20&apiKey=b49acdf6fe454819a2095abc36ee03ac')
  Future<List<ArticleModel>> getTopHeadlinesUS(
     String apiKey,
    String country,
  );
}
