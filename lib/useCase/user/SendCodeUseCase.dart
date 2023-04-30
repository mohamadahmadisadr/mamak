import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/body/user/forgetPassword/ForgetPasswordResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class SendCodeUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is String);
    try {
      flow.emitLoading();
      var uri = createUri(path: UserUrls.forgetPsw);
      var response = await apiServiceImpl.post2(uri,jsonEncode({'mobile': data}));
      if (response.isSuccessful) {
        ForgetPasswordResponse forgetPasswordResponse =
            forgetPasswordResponseFromJson(response.body);
        if (forgetPasswordResponse.isSuccess == true) {
          flow.emitData(forgetPasswordResponse);
        } else {
          flow.throwMessage(forgetPasswordResponse.message ?? '');
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
