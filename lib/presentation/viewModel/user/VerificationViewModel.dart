import 'dart:async';

import 'package:core/utils/timer/MyTimer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/app/ContactUsResponse.dart';
import 'package:mamak/presentation/state/formState/user/VerificationFormState.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/app/GetContactUsUseCase.dart';
import 'package:mamak/useCase/user/SendVerificationCodeUseCase.dart';
import 'package:mamak/useCase/user/VerificationUseCase.dart';

class VerificationViewModel extends BaseViewModel implements OnTimerChange{
  VerificationViewModel(super.initialState) {
    myTimer.setOnChangeListener(this);
    myTimer.startTimer();
    getExtra();
    getContactUsData();
  }

  AppState formUiState = AppState.idle;
  AppState activationCodeState = AppState.idle;
  AppState timerState = AppState.idle;
  String? numberData;
  String? id;
  final int _start = 120;
  late var myTimer = MyTimer(start: _start);
  final StreamController<int> _controller = StreamController();

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
        if (appState.isFailed) {
          messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        }
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
    var data = navigationService.getArgs();
    if (data['username'] != null) {
      verificationFormState.mobile = data['username'];
      id = data['id'];
    }
  }

  void sendActivationCode(){
    if(id == null)return;
    SendVerificationUseCase().invoke(MyFlow(flow: (appState){
      activationCodeState = appState;
      refresh();
      if (appState.isSuccess) {
        myTimer.startTimer();
      }
      if(appState.isFailed){
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }
    }),data: id);
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

  Stream<int> get timerStream => _controller.stream;


  @override
  void onchange(int value) {
    _controller.add(value);
  }


  @override
  Future<void> close() {
    myTimer.dispose();
    return super.close();
  }

  void sendCode() {
    sendActivationCode();
  }
}
