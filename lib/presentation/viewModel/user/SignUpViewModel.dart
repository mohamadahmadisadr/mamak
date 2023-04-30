import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/formState/user/RegisterFormState.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/subscribe/GetSubscribeUseCase.dart';
import 'package:mamak/useCase/user/SignUpUseCase.dart';

class SignUpViewModel extends BaseViewModel {
  NavigationServiceImpl navigationServiceImpl =
      GetIt.I.get<NavigationServiceImpl>();

  var formKey = GlobalKey<FormState>();
  RegisterFormState formState = RegisterFormState();

  SignUpViewModel(super.initialState) {
    fetchSubscribes();
  }

  AppState subscribesState = AppState.idle;

  void fetchSubscribes() {
    GetSubscribeUseCase().invoke(
      MyFlow(
        flow: (subscribesState) {
          this.subscribesState = subscribesState;
        },
      ),
    );
  }

  bool get isValid => formKey.currentState?.validate() == true;

  Function(String) get onMobileChange => (value) => formState.mobile = value;

  Function(String) get onFirstNameChange =>
      (value) => formState.firstName = value;

  Function(String) get onLastNameChange =>
      (value) => formState.lastName = value;

  Function(String) get onPasswordChange =>
      (value) => formState.password = value;

  Function(String) get onConfirmPasswordChange =>
      (value) => formState.confirmPassword = value;

  Function(String) get onEmailChange => (value) => formState.email = value;

  // Function(bool) get onTermsChange => (value) => formState.terms = value;

  Function() register() {
    return () {
      if (isValid) {
        if (formState.password != formState.confirmPassword) {
          messageService.showSnackBar('گذرواژه ها باید یکی باشند');
          return;
        }

        SignUpUseCase().invoke(MyFlow(flow: (appState) {
          if (appState.isSuccess) {
            navigationServiceImpl.replaceTo(
                AppRoute.verification, formState.mobile);
          }
          mainFlow.emit(appState);
        }), data: formState.getBody());
      }
    };
  }

  Function(int?) onItemChanged() {
    return (value) {
      if (value != null) {
        // formState.subscribeId = value;
      }
    };
  }

  Function() gotoLoginPage() => () {
        navigationServiceImpl.replaceTo(AppRoute.login);
      };
}
