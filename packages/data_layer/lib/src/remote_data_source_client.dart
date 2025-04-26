
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'remote_data_source_client.g.dart';

@RestApi(baseUrl: 'https://api.example.com')
abstract class RemoteDataSourceClient{
  factory RemoteDataSourceClient(Dio dio, {String? baseUrl}) = _RemoteDataSourceClient;
}