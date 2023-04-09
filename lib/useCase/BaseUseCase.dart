export 'package:core/network/ApiServiceImpl.dart';
export 'package:core/utils/flow/MyFlow.dart';
export 'package:get_it/get_it.dart';
export 'package:mamak/presentation/state/ErrorModel.dart';
export 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

abstract class BaseUseCase {
  ApiServiceImpl apiServiceImpl = GetIt.I.get<ApiServiceImpl>();

  void invoke(MyFlow<AppState> flow);
}
