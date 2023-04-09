import 'package:mamak/data/body/LoginBody.dart';
import 'package:mamak/presentation/state/formState/user/LoginFormState.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class LoginUseCase extends BaseUseCase {
  LoginUseCase.initFormState({required this.loginFormState});

  LoginFormState loginFormState;

  @override
  void invoke(MyFlow<AppState> flow) async {
    // try {
    //   flow.emit(AppState.loading);
    //   LoginBody loginBody = LoginBody(
    //     mobile: loginFormState.mobile,
    //     password: loginFormState.password,
    //   );
    //
    //   Uri uri = UriCreator.createUri(
    //       path: UserApiRoutes.login, body: loginBody.toJson());
    //   var response = await apiService.post(uri);
    //   if (response.isSuccessful) {
    //     /**
    //      * [RegisterResponse.dart] is same with login response
    //      */
    //     Logger.d(response.body);
    //     var registerResponse = registerResponseFromJson(response.body);
    //     if (registerResponse.status == 1 &&
    //         (registerResponse.data?.state == 1 ||
    //             registerResponse.data?.state == 5)) {
    //       flow.emit(AppState.success(registerResponse));
    //     } else {
    //       flow.emit(
    //         AppState.error(
    //           ErrorModel(
    //             state: ErrorState.Message,
    //             message: registerResponse.data?.message ?? '',
    //           ),
    //         ),
    //       );
    //     }
    //   } else {
    //     flow.emit(
    //       AppState.error(
    //         ErrorHandlerImpl().makeError(response),
    //       ),
    //     );
    //   }
    // } catch (e) {
    //   Logger.e(e);
    //   flow.emit(
    //     AppState.error(
    //       const ErrorModel(
    //         state: ErrorState.Message,
    //         message: ErrorMessages.ErrorMessage_Connection,
    //       ),
    //     ),
    //   );
    // }
  }
}
