import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/formState/app/ContactUsFormState.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/app/ContactUsUseCase.dart';

class ContactUsViewModel extends BaseViewModel {
  ContactUsViewModel(super.initialState);

  ContactUsFormState formState = ContactUsFormState();
  final formKey = GlobalKey<FormState>();

  onNameChange(String name) => formState.fullName = name;

  onEmailChange(String email) => formState.email = email;

  onMobileChange(String mobile) => formState.mobile = mobile;

  onSubChange(String sub) => formState.subject = sub;

  onTextChange(String text) => formState.message = text;

  void submitForm() {
    if (formState.subject == '') {
      messageService.showSnackBar('موضوع را وارد کنید');
      return;
    }
    if (formState.message == '') {
      messageService.showSnackBar('متن را وارد کنید');
      return;
    }

    if (formKey.currentState?.validate() == true) {
      ContactUsUseCase().invoke(MyFlow(flow: (appState) {
        if (appState.isSuccess) {
          messageService.showSnackBar('با موفقیت ارسال شد');
        }
        mainFlow.emit(appState);
      }), data: formState.createBody());
    }
  }
}
