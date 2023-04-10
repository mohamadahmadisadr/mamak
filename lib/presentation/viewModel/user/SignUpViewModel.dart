import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/formState/user/RegisterFormState.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/subscribe/GetSubscribeUseCase.dart';
import 'package:rxdart/rxdart.dart';

class SignUpViewModel extends BaseViewModel {
  var formKey = GlobalKey<FormState>();
  BehaviorSubject<RegisterFormState> formState = BehaviorSubject();

  int selectedItem = 0;

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

  Function(String) get onMobileChange =>
      (value) => formState.value.mobile = value;

  Function(String) get onFirstNameChange =>
      (value) => formState.value.firstName = value;

  Function(String) get onLastNameChange =>
      (value) => formState.value.lastName = value;

  Function(String) get onPasswordChange =>
      (value) => formState.value.password = value;

  Function(String) get onRePswChange =>
      (value) => formState.value.rePassword = value;

  Function(bool) get onTermsChange => (value) => formState.value.terms = value;

  Function() register() {
    return () {
      if (isValid) {}
    };
  }

  Function(int?) onItemChanged() {
    return (value) {
      if (value != null) {
        selectedItem = value;
      }
    };
  }
}
