import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/formState/user/VerificationFormState.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/user/VerificationUseCase.dart';

class VerificationViewModel extends BaseViewModel {
  VerificationViewModel(super.initialState) {
    getExtra();
  }

  final formState = GlobalKey<FormState>();
  final navigationService = GetIt.I.get<NavigationServiceImpl>();

  final VerificationFormState verificationFormState = VerificationFormState();

  onCodeChange(String value) => verificationFormState.activationCode = value;

  void onSubmitCodeClick() {
    if (verificationFormState.mobile.isEmpty) {
      messageService.showSnackBar('سشن منقضی شده ست مجددا وارد شوید');
      return;
    }
    if (formState.currentState?.validate() == true) {
      VerificationUseCase().invoke(MyFlow(flow: (appState) {
        if (appState.isSuccess) {
          navigationService.replaceTo(AppRoute.login);
        }
        postResult(appState);
      }), data: verificationFormState.createBody());
    }
  }

  void getExtra() {
    var mobile = navigationService.getArgs<String>();
    if (mobile != null) {
      verificationFormState.mobile = mobile;
    }
  }
}
