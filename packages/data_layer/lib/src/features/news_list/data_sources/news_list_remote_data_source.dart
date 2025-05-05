import 'package:data_layer/src/features/news_list/models/get_top_headline_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'news_list_remote_data_source.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2/')
abstract class NewsListRemoteDataSource {
  factory NewsListRemoteDataSource(Dio dio, {String? baseUrl}) =
      _NewsListRemoteDataSource;

  @GET(
      '/everything')
  Future<GetTopHeadlineResponse> getTopHeadlinesUS(
      @Query('apiKey') String apiKey,
      @Query('page') int page,
      @Query('pageSize') int pageSize,
      @Query('q') String query,
      @Query('from') String fromDate,
      @Query('to') String toDate,
      @Query("language") String language,
      @Query("sortBy") String sortBy,
  );
}
