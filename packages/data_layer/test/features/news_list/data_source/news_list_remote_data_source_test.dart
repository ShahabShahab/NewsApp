import 'package:data_layer/src/features/news_list/data_sources/news_list_remote_data_source.dart';
import 'package:test/test.dart';

import '../../mocks/mock_dio.dart';

void main() {
  late MockDio mockDio;
  late NewsListRemoteDataSource newsListRemoteDataSource;

  setUpAll(() {
    mockDio = MockDio();
    newsListRemoteDataSource = NewsListRemoteDataSource(mockDio);
  });
}
