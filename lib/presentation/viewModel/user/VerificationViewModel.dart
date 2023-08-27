import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/app/ContactUsResponse.dart';
import 'package:mamak/presentation/state/formState/user/VerificationFormState.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/app/GetContactUsUseCase.dart';
import 'package:mamak/useCase/user/VerificationUseCase.dart';

class VerificationViewModel extends BaseViewModel {
  VerificationViewModel(super.initialState) {
    getExtra();
    getContactUsData();
  }

  AppState formUiState = AppState.idle;
  String? numberData;

  final formState = GlobalKey<FormState>();
  final navigationService = GetIt.I.get<NavigationServiceImpl>();

  final VerificationFormState verificationFormState = VerificationFormState();

  onCodeChange(String value) => verificationFormState.activationCode = value;

  void onSubmitCodeClick() {
    if (verificationFormState.mobile.isEmpty) {
      messageService.showSnackBar('ErrorMessage_4_0_1'.tr);
      return;
    }
    if (formState.currentState?.validate() == true) {
      VerificationUseCase().invoke(MyFlow(flow: (appState) {
        if (appState.isSuccess) {
          navigationService.replaceTo(AppRoute.login);
        }
        formUiState = appState;
        refresh();
      }), data: verificationFormState.createBody());
    }
  }


  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  void getExtra() {
    var mobile = navigationService.getArgs<String>();
    if (mobile != null) {
      verificationFormState.mobile = mobile;
    }
  }


  void getContactUsData() {
    GetContactUsUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is ContactUsResponse) {
        ContactUsResponse data = appState.getData;
        numberData = '${'contact_us'.tr} : ${data.tellNumber}';
        refresh();
      }
    }));
  }
}
