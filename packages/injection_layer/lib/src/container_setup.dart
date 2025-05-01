import 'package:data_layer/data_layer.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:injection_layer/injection_layer.dart';

Future<void> initDependencies({required String localDateBaseDirectory}) async {
  registerLazySingleton<LocalDataSourceClient>(() => LocalDataSourceClient());

  await resolve<LocalDataSourceClient>()
      .initLocalDatabase(directory: localDateBaseDirectory);

  registerLazySingleton<NewsListLocalDataSource>(
      (() => NewsListLocalDataSource()));

  registerLazySingleton<NewsListRemoteDataSource>(
      () => NewsListRemoteDataSource(HttpClient.getInstance()));

  registerFactory<NewsRepository>(() => NewsListRepositoryImpl(
      remoteDataSource: resolve<NewsListRemoteDataSource>(),
      localDataSource: resolve<NewsListLocalDataSource>()));
}
