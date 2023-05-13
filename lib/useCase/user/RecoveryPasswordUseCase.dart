import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/body/user/recoveryPassword/RecoveryPasswordBody.dart';
import 'package:mamak/data/serializer/user/ChangePasswordResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class RecoveryPasswordUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is RecoveryPasswordBody);
    assert((data as RecoveryPasswordBody).mobile != '',
        'The mobile have not to empty');

    try {
      flow.emitLoading();

      var uri = createUri(path: UserUrls.postRecoveryPassword);
      var response = await apiServiceImpl.post2(uri, jsonEncode(data));
      if (response.isSuccessful) {
        var result = response.result;
        if(result.isSuccessFull){
          flow.emitData('');
        }else{
          flow.throwMessage(result.concatErrorMessages);
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      flow.throwCatch();
    }
  }
}
