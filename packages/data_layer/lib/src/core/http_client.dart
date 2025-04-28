import 'package:dio/dio.dart';

class HttpClient {
  static Dio getInstance() {
    final Dio dio = Dio(BaseOptions(
      connectTimeout: Duration(seconds: 100),
      receiveTimeout: Duration(seconds: 100),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {},
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        return handler.next(error);
      },
    ));

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    return dio;
  }
}
