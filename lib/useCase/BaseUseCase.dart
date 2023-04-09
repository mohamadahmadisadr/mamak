import 'package:core/network/ApiServiceImpl.dart';
import 'package:core/utils/flow/MyFlow.dart';
import 'package:get_it/get_it.dart';
import 'package:mamak/presentation/state/app_state.dart';

abstract class BaseUseCase {
  ApiServiceImpl apiServiceImpl = GetIt.I.get<ApiServiceImpl>();

  void invoke(MyFlow<AppState> flow);
}
