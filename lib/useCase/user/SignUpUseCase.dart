import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

import '../../data/body/user/register/SignUpBody.dart';

class SignUpUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is SignUpBody);
    try {
      flow.emitLoading();
      var uri = createUri(path: UserUrls.signUp);
      var response = await apiServiceImpl.post2(uri, jsonEncode(data));
      if (response.isSuccessful) {
        var result = response.result;
        if (result.resultCode == 406) {
          flow.emitData(406);
        } else {
          if (result.isSuccessFull) {
            flow.emitData(result);
          } else {
            flow.throwMessage(result.concatErrorMessages);
          }
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch();
    }
  }
}
