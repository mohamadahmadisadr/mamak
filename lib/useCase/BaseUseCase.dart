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

  void invoke(MyFlow<AppState> flow);
}
