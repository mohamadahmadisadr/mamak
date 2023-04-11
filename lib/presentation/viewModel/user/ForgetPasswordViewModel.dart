import 'dart:async';

import 'package:core/utils/logger/Logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/user/ConfirmCodeUseCase.dart';
import 'package:mamak/useCase/user/SendCodeUseCase.dart';
import 'package:core/utils/timer/MyTimer.dart';

class ForgetPasswordViewModel extends BaseViewModel implements OnTimerChange {
  ForgetPasswordViewModel(super.initialState) {
    myTimer.setOnChangeListener(this);
  }

  final int _start = 120;
  late var myTimer = MyTimer(start: _start);
  final StreamController<int> _controller = StreamController();

  Stream<int> get timerStream => _controller.stream;

  var mobileController = TextEditingController();
  var confirmCodeController = TextEditingController();

  Function(String) get onMobileChange =>
      (mobile) => mobileController.text = mobile;

  Function(String) get onCodeChange => (code) {
    Logger.d(code.length);
        confirmCodeController.text = code;
        if (code.length == 5) {
          confirmCode();
        }
      };

  Function() sendCode() => () {
        if (mobileController.text.isEmpty) {
          messageService.showSnackBar('شماره موبایل را وارد کنید');
          return;
        }
        SendCodeUseCase().invoke(MyFlow(flow: (appState) {
          postResult(appState);
          if (appState.isSuccess) {
            myTimer.startTimer();
          }
          if (appState.isFailed) {
            messageService.showSnackBar(appState.getErrorModel?.message ?? '');
          }
        }), data: mobileController.text);
      };

  Function() confirmCode() => () {
        if (mobileController.text.isEmpty) {
          messageService.showSnackBar('شماره موبایل را وارد کنید');
          return;
        }

        if (confirmCodeController.text.isEmpty) {
          messageService.showSnackBar(' کد تایید را وارد کنید');
          return;
        }

        var data = {
          'mobile': mobileController.text,
          'confirmCode': confirmCodeController.text
        };

        ConfirmCodeUseCase().invoke(MyFlow(flow: (appState) {
          postResult(appState);
          if (appState.isSuccess) {
            //TODO navigate
            Logger.d('success');
          }
          if (appState.isFailed) {
            messageService.showSnackBar(appState.getErrorModel?.message ?? '');
          }
        }), data: data);
      };

  @override
  void onchange(int value) {
    _controller.add(value);
  }

  @override
  Future<void> close() {
    myTimer.dispose();
    return super.close();
  }
}
