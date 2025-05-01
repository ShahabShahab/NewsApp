import 'package:data_layer/src/features/splash/data_source/splash_remote_data_source.dart';
import 'package:data_layer/src/features/splash/model/app_config_model.dart';
import 'package:domain_layer/domain_layer.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource remoteDataSource;

  SplashRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<DomainFailure, AppConfig>> getAppConfig() async {
    try {
      final response = await remoteDataSource.getRemoteAppConfig();
      AppConfig appConfig = _convertResponse(response);
      return Right(value: appConfig);
    } catch (e) {
      return Left(value: ServerFailure());
    }
  }

  AppConfig _convertResponse(AppConfigModel response) {
    return AppConfig();
  }
}
