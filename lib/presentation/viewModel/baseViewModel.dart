// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:rxdart/rxdart.dart';

class BaseViewModel extends Cubit<AppState> {
  // var messageService = GetIt.I.get<MessagingServiceImpl>();

  final message = BehaviorSubject<String>();

  // final model = GetIt.I.get<BaseModel>();
  // final session = GetIt.I.get<SessionManager>();

  BaseViewModel(super.initialState);

  void updateState(AppState newSate) {
    emit.call(newSate);
  }

  void postResult(AppState appState) => updateState(appState);

  void postLoader() {
    if (isClosed) {
      return;
    }
    updateState(AppState.loading);
  }

  void postIdle({dynamic data}) {
    if (isClosed) {
      return;
    }
    updateState(AppState.idle);
  }

  void updateScreen({required double time}) {
    if (isClosed) {
      return;
    }
    updateState(AppState.fresh(time));
  }

  void postSuccess({dynamic data}) {
    if (isClosed) {
      return;
    }
    updateState(AppState.success(data));
  }
}
