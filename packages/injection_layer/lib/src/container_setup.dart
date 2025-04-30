import 'package:data_layer/data_layer.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:injection_layer/injection_layer.dart';

Future<void> setUpDependencies() async {
  registerLazySingleton<LocalDataSourceClient>(() => LocalDataSourceClient());

  await resolve<LocalDataSourceClient>().initLocalDatabase();

  registerLazySingleton<NewsListRemoteDataSource>(
      () => NewsListRemoteDataSource(HttpClient.getInstance()));
  registerFactory<NewsRepository>(() =>
      NewsListRepositoryImpl(dataSource: resolve<NewsListRemoteDataSource>()));
}
