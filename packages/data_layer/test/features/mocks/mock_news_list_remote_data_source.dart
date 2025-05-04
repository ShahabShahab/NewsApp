import 'package:data_layer/data_layer.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsListRemoteDataSource extends Mock
    implements NewsListRemoteDataSource {}

class MockNewsListLocalDataSource extends Mock
    implements NewsListLocalDataSource {}

class MockConnectivityService extends Mock implements ConnectivityService {}
