import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/SignInResponse.dart';
import 'package:mamak/presentation/state/formState/user/LoginFormState.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/user/LoginUseCase.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BaseViewModel {
  var navigationService = GetIt.I.get<NavigationServiceImpl>();
  var formKey = GlobalKey<FormState>();
  var loginFormState = BehaviorSubject<LoginFormState>();
  late final loginUseCase =
      LoginUseCase.initFormState(loginFormState: loginFormState.value);

  LoginViewModel(super.initialState) {
    loginFormState.value = LoginFormState();
    // getExtra();
  }

  // void getExtra() {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
  //   Logger.d('getting extra');
  //   var modal = Get.arguments;
  //   Logger.d(modal.toString());
  //   if (modal is User && modal.mobile != null) {
  //     Logger.d(modal.mobile.toString());
  //     loginFormState.value.mobile = modal.mobile!;
  //   }
  // }

  bool get isValid => formKey.currentState?.validate() == true;

  Function(String) get onMobileChange =>
      (value) => loginFormState.value.mobile = value;

  Function(String) get onPasswordChange =>
      (value) => loginFormState.value.password = value;

  Function() loginUser() {
    return () {
      if (isValid) {
        loginUseCase.invoke(
          MyFlow(flow: (state) {
            postResult(state);
            if (state.isSuccess && state.getData is SignInResponse) {
              var registerResponse = state.getData as SignInResponse;
              var user = registerResponse.data;
              if (user != null) {
                saveUserData(user);
              } else {
                navigationService.replaceTo(AppRoute.verification, user);
              }
            } else if (state.isFailed) {
              messageService.showSnackBar(state.getErrorModel?.message ?? '');
            }
          }),
        );
      }
    };
  }

  Function() gotoSignUpPage() => () {
        navigationService.replaceTo(AppRoute.register);
      };

  Future<bool> saveUserData(User user) {
    var map = {
      UserSessionConst.id: user.userId?.toString() ?? '0',
      UserSessionConst.fullName: '${user.fullName}',
      UserSessionConst.mobile: user.mobile ?? '',
    };
    session.insertData(map);
    return Future.value(true);
  }

  Function() pushToRegister() =>
      () => navigationService.replaceTo(AppRoute.register);

  Function() pushToForgetPassword() =>
      () => navigationService.navigateTo(AppRoute.forgetPassword);

  Function() pushToVerificationPage(User user) =>
      () => navigationService.replaceTo(AppRoute.register, user);
}
