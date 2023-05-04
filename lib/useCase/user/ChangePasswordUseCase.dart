import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/body/user/changePassword/ChangePasswordBody.dart';
import 'package:mamak/data/serializer/user/ChangePasswordResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class ChangePasswordUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is ChangePasswordBody);


    try {
      flow.emitLoading();

      var uri = createUri(path: UserUrls.postChangePassword);
      var response = await apiServiceImpl.post2(uri, jsonEncode(data));
      if (response.isSuccessful) {
        var chanePasswordResponse =
            changePasswordResponseFromJson(response.body);
        if (chanePasswordResponse.isSuccess == true) {
          flow.emitData(chanePasswordResponse);
        } else {
          flow.throwMessage(chanePasswordResponse.message ?? '');
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      flow.throwCatch();
    }
  }
}
