import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/state/formState/user/recovery_password_form_state.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/user/RecoveryPasswordUseCase.dart';

class RecoveryPasswordViewModel extends BaseViewModel {
  RecoveryPasswordViewModel(super.initialState) {
    getUserData();
  }

  final formKey = GlobalKey<FormState>();
  RecoveryPasswordFormState formState = RecoveryPasswordFormState();

  final NavigationServiceImpl _navigationServiceImpl =
      GetIt.I.get<NavigationServiceImpl>();

  Function(String) get onPasswordChange =>
      (mobile) => formState.password = mobile;

  Function(String) get onConfirmPasswordChange =>
      (mobile) => formState.confirmPassword = mobile;

  void getUserData() async {
    var extraData = _navigationServiceImpl.getArgs();
    if (extraData != null && extraData is RecoveryPasswordFormState) {
      formState = extraData;
    }
  }

  void onSubmitClick() {
    if (formKey.currentState?.validate() == true) {
      if (formState.password != formState.confirmPassword) {
        messageService
            .showSnackBar('not_same_psw'.tr);
        return;
      }
      if (formState.mobile == '') {
        messageService.showSnackBar('get_code_and_try'.tr);
        return;
      }
      //TODO replace with recovery password
      RecoveryPasswordUseCase().invoke(MyFlow(flow: (appState){
        postResult(appState);
        if(appState.isSuccess){
          _navigationServiceImpl.replaceTo(AppRoute.login);
        }
      }), data: formState.createBody());
    }
  }
}
