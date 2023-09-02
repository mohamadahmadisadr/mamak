import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/body/user/login/LoginBody.dart';
import 'package:mamak/data/serializer/user/User.dart';
import 'package:mamak/presentation/state/formState/user/LoginFormState.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class LoginUseCase extends BaseUseCase {
  LoginUseCase.initFormState({required this.loginFormState});

  LoginFormState loginFormState;

  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();
      LoginBody loginBody = LoginBody(
        username: loginFormState.username,
        password: loginFormState.password,
      );

      Uri uri = createUri(path: UserUrls.signIn);
      var response =
          await apiServiceImpl.post(uri, data: jsonEncode(loginBody));
      if (response.isSuccessful) {
        var result = response.result;
        if (result.resultCode == 406) {
          flow.emitData(406);
        } else {
          if (result.isSuccessFull) {
            flow.emitData(userFromJson(result.result ?? ''));
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
