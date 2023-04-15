import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/formState/user/change_password_form_state.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class ChangePasswordViewModel extends BaseViewModel {
  ChangePasswordViewModel(super.initialState);

  final formKey = GlobalKey<FormState>();
  ChangePasswordFormState formState = ChangePasswordFormState();



  Function(String) get onCurrentPasswordChange =>
          (mobile) => formState.password = mobile;

  Function(String) get onPasswordChange =>
          (mobile) => formState.confirmPassword = mobile;

  Function(String) get oncONFIRMPasswordChange =>
          (mobile) => formState.confirmPassword = mobile;
}
