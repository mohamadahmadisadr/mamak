import 'package:http/http.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

export 'dart:convert';

export 'package:core/network/ApiServiceImpl.dart';
export 'package:core/network/UriCreator.dart';
export 'package:core/network/errorHandler/ErrorHandlerImpl.dart';
export 'package:core/utils/flow/MyFlow.dart';
export 'package:core/utils/logger/Logger.dart';
export 'package:get_it/get_it.dart';
export 'package:mamak/config/apiRoute/BaseUrls.dart';
export 'package:mamak/presentation/extensions/ResponseExtension.dart';
export 'package:mamak/presentation/state/app_state.dart';

abstract class BaseUseCase {
  ApiServiceImpl apiServiceImpl = GetIt.I.get<ApiServiceImpl>();

  void invoke(MyFlow<AppState> flow, {Object? data});

  Uri createUri({String? path, Map<String, dynamic>? body}) {
    return UriCreator.createUriWithUrl(
        url: BaseUrls.baseUrl,
        path: BaseUrls.basePath + (path ?? ''),
        body: body);
  }
}

extension FlowExtension on MyFlow<AppState> {
  void throwCatch() {
    emit(
      AppState.error(
        const ErrorModel(
          state: ErrorState.Message,
          message: ErrorMessages.ErrorMessage_Connection,
        ),
      ),
    );
  }

  void throwError(Response? response, {int? statusCode}) {
    if (response != null) {
      emit(
        AppState.error(
          ErrorHandlerImpl().makeError(response),
        ),
      );
    }
    if (statusCode != null) {
      emit(
        AppState.error(
          ErrorHandlerImpl().makeErrorByStatusCode(statusCode),
        ),
      );
    }
  }

  void throwMessage(String msg) {
    emit(
      AppState.error(ErrorModel(state: ErrorState.Message, message: msg)),
    );
  }

  void emitLoading() {
    emit(AppState.loading);
  }

  void emitData(dynamic data) {
    emit(AppState.success(data));
  }
}
