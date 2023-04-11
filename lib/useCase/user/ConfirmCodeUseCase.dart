import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/serializer/user/ConfirmCodeResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class ConfirmCodeUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null);
    try {
      flow.emitLoading();
      var uri = createUri(
          path: UserUrls.confirmCode, body: data as Map<String, dynamic>);
      var response = await apiServiceImpl.post(uri);
      if (response.isSuccessful) {
        ConfirmCodeResponse codeResponse =
            confirmCodeResponseFromJson(response.body);
        if (codeResponse.isSuccess == true) {
          flow.emitData(codeResponse);
        } else {
          flow.throwMessage(codeResponse.message ?? '');
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      flow.throwCatch();
    }
  }
}
