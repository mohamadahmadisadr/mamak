import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/state/formState/user/change_password_form_state.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/user/ChangePasswordUseCase.dart';

class ChangePasswordViewModel extends BaseViewModel {
  ChangePasswordViewModel(super.initialState) {
    fillMobile();
  }

  final formKey = GlobalKey<FormState>();
  ChangePasswordFormState formState = ChangePasswordFormState();

  Function(String) get onCurrentPasswordChange =>
      (mobile) => formState.currentPassword = mobile;

  Function(String) get onPasswordChange =>
      (mobile) => formState.password = mobile;

  Function(String) get onConfirmPasswordChange =>
      (mobile) => formState.confirmPassword = mobile;

  void fillMobile() async {
    var mobile = await session.getData(UserSessionConst.mobile);
    formState.mobile = mobile;
  }

  void onSubmitClick() {
    if (formKey.currentState?.validate() == true) {
      if (formState.password != formState.confirmPassword) {
        messageService
            .showSnackBar('not_same_psw'.tr);
        return;
      }
      if(formState.mobile == ''){
        messageService
            .showSnackBar('pls_login_msg'.tr);
        return;
      }
      ChangePasswordUseCase().invoke(mainFlow, data: formState.createBody());
    }
  }
}
