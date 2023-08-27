import 'package:core/dioNetwork/network.dart';
import 'package:feature/session/LocalSessionImpl.dart';
import 'package:mamak/core/network/errorHandler/ErrorHandlerImpl.dart';
import 'package:mamak/core/network/errorHandler/ErrorModel.dart';
import 'package:mamak/core/network/errorHandler/common/ErrorMessages.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

export 'dart:convert';

export 'package:core/dioNetwork/response/KanoonHttpResponse.dart';
export 'package:core/network/ApiServiceImpl.dart';
export 'package:core/network/UriCreator.dart';
export 'package:core/utils/flow/MyFlow.dart';
export 'package:core/utils/logger/Logger.dart';
export 'package:get_it/get_it.dart';
export 'package:mamak/config/apiRoute/BaseUrls.dart';
export 'package:mamak/core/network/ResponseExtension.dart';
export 'package:mamak/presentation/state/app_state.dart';

abstract class BaseUseCase {
  KanoonHttp apiServiceImpl = GetIt.I.get();
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();

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
        ErrorModel(
          state: ErrorState.Message,
          message: ErrorMessages().ErrorMessage_Connection,
        ),
      ),
    );
  }

  void throwError(KanoonHttpResponse? response, {int? statusCode}) {
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

  void successMessage(String msg) {
    emit(
      AppState.error(ErrorModel(state: ErrorState.SuccessMsg, message: msg)),
    );
  }

  void throwEmptyDataMessage(String msg) {
    emit(
      AppState.error(ErrorModel(state: ErrorState.Empty, message: msg)),
    );
  }

  void emitLoading() {
    emit(AppState.loading);
  }

  void emitData(dynamic data) {
    emit(AppState.success(data));
  }
}
