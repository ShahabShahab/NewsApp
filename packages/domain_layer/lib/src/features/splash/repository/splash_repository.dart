import 'package:domain_layer/domain_layer.dart';
import 'package:domain_layer/src/features/splash/entity/app_config.dart';

abstract class SplashRepository{
  Future<Either<DomainFailure, AppConfig>> getAppConfig();
}