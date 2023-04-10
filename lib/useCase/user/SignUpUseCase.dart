import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/serializer/user/SignUpResponse.dart';
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
        var signUpResponse = signUpResponseFromJson(response.body);
        if (signUpResponse.isSuccess == true) {
          flow.emitData(signUpResponse);
        } else {
          flow.throwMessage(signUpResponse.message ?? '');
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
