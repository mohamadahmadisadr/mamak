import 'package:core/utils/flow/MyFlow.dart';
import 'package:feature/navigation/NavigationService.dart';
import 'package:feature/session/LocalSessionImpl.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mamak/data/serializer/SignInResponse.dart';
import 'package:mamak/presentation/state/NetworkExtensions.dart';
import 'package:mamak/presentation/state/formState/user/LoginFormState.dart';
import 'package:mamak/useCase/user/LoginUseCase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/config/appData/route/AppRoute.dart';

class LoginViewModel extends BaseViewModel {
  var navigationService = GetIt.I.get<NavigationServiceImpl>();
  var sessionManager = GetIt.I.get<LocalSessionImpl>();
  var formKey = GlobalKey<FormState>();
  var loginFormState = BehaviorSubject<LoginFormState>();
  late final loginUseCase =
      LoginUseCase.initFormState(loginFormState: loginFormState.value);

  LoginViewModel(super.initialState) {
    loginFormState.value = LoginFormState();
    // getExtra();
  }

  // void getExtra() {
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

  @override
  Future<void> close() {
    return super.close();
  }


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

  Future<bool> saveUserData(User user) {
    // var map = {
    //   UserSessionConst.id: user.id?.toString() ?? '0',
    //   UserSessionConst.fullName: '${user.firstName} ${user.lastName}',
    //   UserSessionConst.paye: user.groupName ?? '',
    //   UserSessionConst.nationalCode: user.nationalCode?.toString() ?? '',
    //   UserSessionConst.mobile: user.mobile ?? '',
    // };
    // sessionManager.insertData(map);
    return Future.value(true);
  }

  Function() pushToRegister() =>
      () => navigationService.replaceTo(AppRoute.register);

  Function() pushToForgetPassword() =>
      () => navigationService.navigateTo(AppRoute.forgetPassword);

  Function() pushToVerificationPage(User user) =>
      () => navigationService.replaceTo(AppRoute.register, user);
}
