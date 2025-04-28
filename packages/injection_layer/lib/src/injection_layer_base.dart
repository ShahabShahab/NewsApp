// TODO: Put public facing types in this file.

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void registerSingleton<T extends Object>(T instance) {
  sl.registerSingleton<T>(instance);
}

void registerLazySingleton<T extends Object>(T Function() factory) {
  sl.registerLazySingleton<T>(factory);
}

void registerFactory<T extends Object>(T Function() factory) {
  sl.registerFactory<T>(factory);
}

T resolve<T extends Object>() {
  return sl<T>();
}
