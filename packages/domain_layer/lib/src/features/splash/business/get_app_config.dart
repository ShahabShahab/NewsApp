import 'package:domain_layer/domain_layer.dart';
import 'package:domain_layer/src/features/splash/entity/app_config.dart';
import 'package:domain_layer/src/features/splash/repository/splash_repository.dart';

class GetAppConfig {
  final SplashRepository splashRepository;

  GetAppConfig({required this.splashRepository});

  Future<Either<DomainFailure, AppConfig>> call() async {
    return await splashRepository.getAppConfig();
  }
}
