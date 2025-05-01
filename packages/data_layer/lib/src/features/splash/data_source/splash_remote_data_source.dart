import 'package:data_layer/src/features/splash/model/app_config_model.dart';

class SplashRemoteDataSource {
  Future<AppConfigModel> getRemoteAppConfig() async {
    await Future.delayed(Duration(seconds: 5));
    return AppConfigModel();
  }
}
