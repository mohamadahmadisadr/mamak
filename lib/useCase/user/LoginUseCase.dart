
import 'package:mamak/config/apiRoute/user/UserUrls.dart';
import 'package:mamak/data/body/LoginBody.dart';
import 'package:mamak/data/serializer/SignInResponse.dart';
import 'package:mamak/presentation/state/formState/user/LoginFormState.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class LoginUseCase extends BaseUseCase {
  LoginUseCase.initFormState({required this.loginFormState});

  LoginFormState loginFormState;

  @override
  void invoke(MyFlow<AppState> flow) async {
    try {
      flow.emit(AppState.loading);
      LoginBody loginBody = LoginBody(
        mobile: loginFormState.mobile,
        password: loginFormState.password,
      );

      Uri uri = UriCreator.createUriWithUrl(
          url: BaseUrls.baseUrl, path: BaseUrls.basePath + UserUrls.signIn);
      var response = await apiServiceImpl.post2(uri, jsonEncode(loginBody));
      if (response.isSuccessful) {
        var registerResponse = signInResponseFromJson(response.body);
        flow.emit(AppState.success(registerResponse));
      } else {
        flow.emit(
          AppState.error(
            ErrorHandlerImpl().makeError(response),
          ),
        );
      }
    } catch (e) {
      Logger.e(e);
      flow.emit(
        AppState.error(
          const ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages.ErrorMessage_Connection,
          ),
        ),
      );
    }
  }
}
