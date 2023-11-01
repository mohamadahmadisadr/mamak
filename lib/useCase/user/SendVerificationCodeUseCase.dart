import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/body/user/login/LoginBody.dart';
import 'package:mamak/data/serializer/user/User.dart';
import 'package:mamak/presentation/state/formState/user/LoginFormState.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class SendVerificationUseCase extends BaseUseCase {

  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      assert(data != null && data is String);
      flow.emitLoading();
      Uri uri = createUri(path: UserUrls.postSendActivationCode);
      var response =
          await apiServiceImpl.post(uri, data: jsonEncode({'userId':data}));
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData('');
        } else {
          flow.throwMessage(result.concatErrorMessages);
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
