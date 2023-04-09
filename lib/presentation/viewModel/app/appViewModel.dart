import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mamak/di/appModule.dart';

import '../../state/app_state.dart';

class AppViewModel extends Cubit<AppState> {
  AppViewModel(super.initialState) {
    AppModule.initModules();
  }

  static AppViewModel getInstance = AppViewModel(AppState.idle);

  @override
  Future<void> close() {
    GetIt.I.get<Client>().close();
    return super.close();
  }
}
