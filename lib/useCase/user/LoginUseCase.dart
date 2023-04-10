import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/body/user/login/LoginBody.dart';
import 'package:mamak/data/serializer/SignInResponse.dart';
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
        mobile: loginFormState.mobile,
        password: loginFormState.password,
      );

      Uri uri = createUri(path: UserUrls.signIn);
      var response = await apiServiceImpl.post2(uri, jsonEncode(loginBody));
      if (response.isSuccessful) {
        var registerResponse = signInResponseFromJson(response.body);
        flow.emitData(registerResponse);
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch();
    }
  }
}
