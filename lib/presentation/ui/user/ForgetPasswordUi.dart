import 'package:feature/form/validator/login/MobileValidator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/register/RegisterUi.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/user/ForgetPasswordViewModel.dart';

class ForgetPasswordUi extends StatelessWidget {
  const ForgetPasswordUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ForgetPasswordViewModel(AppState.idle),
      builder: (bloc, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Form(
              key: bloc.formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  20.dpv,
                  Text(
                    "forgot_password".tr,
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  20.dpv,
                  FormTitleWithStar(title: "mobile".tr),
                  4.dpv,
                  TextFormFieldHelper(
                    label: "mobile".tr,
                    hint: "mobile".tr,
                    keyboardType: TextInputType.phone,
                    onChangeValue: bloc.onMobileChange,
                    validator: MobileValidator(),
                  ),
                  10.dpv,
                  StreamBuilder<int>(
                    stream: bloc.timerStream,
                    initialData: 0,
                    builder: (context, snapshot) {
                      if (snapshot.data == 0) {
                        return ElevatedButton(
                            onPressed: bloc.sendCode.call(),
                            child: bloc.state.isLoading
                                ? const MyLoader()
                                : Text('send_code'.tr));
                      }
                      return bloc.state.isLoading
                          ? const MyLoader()
                          : Text(
                              "'${'code_sent'.tr}' ${bloc.myTimer.formatTime()}",
                              textAlign: TextAlign.center,
                            );
                    },
                  ),
                  10.dpv,
                    Text('enter_confirm_code'.tr),
                  4.dpv,
                  TextFormFieldHelper(
                    label: "",
                    hint: "",
                    keyboardType: TextInputType.number,
                    onChangeValue: bloc.onCodeChange,
                    labelStyle:
                        const TextStyle(letterSpacing: 30, fontSize: 25),
                    textAlign: TextAlign.center,
                    maxLength: 5,
                    onCompleted: bloc.confirmCode.call(),
                  ),
                  10.dpv,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
