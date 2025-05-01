import 'package:bloc/bloc.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetAppConfig getAppConfig;

  SplashCubit(this.getAppConfig) : super(SplashInitial()){
    getAppInitialConfig();
  }

  Future<void> getAppInitialConfig() async {
    final response = await getAppConfig();
    response.fold((failure){

    }, (data){
      emit(AppConfigLoaded());
    });

  }
}
