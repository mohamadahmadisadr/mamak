import 'package:feature/form/validator/login/MobileValidator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/presentation/state/NetworkExtensions.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakLogo.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/PasswordFieldHelper.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/user/LoginViewModel.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => LoginViewModel(AppState.idle),
      builder: (bloc, state) {
        return Padding(
          padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
          child: Form(
            key: bloc.formKey,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    20.dpv,
                    const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MamakLogo(),
                      ],
                    ),
                    20.dpv,
                    Text(
                      "شماره همراه",
                      style: context.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    4.dpv,
                    TextFormFieldHelper(
                      label: "شماره همراه",
                      hint: "شماره همراه",
                      keyboardType: TextInputType.phone,
                      onChangeValue: bloc.onMobileChange,
                      validator: MobileValidator(),
                      maxLength: 11,
                    ),
                    10.dpv,
                    Text(
                      "رمز عبور",
                      style: context.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    4.dpv,
                    PasswordFieldHelper(onChangeValue: bloc.onPasswordChange),
                    20.dpv,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: bloc.pushToForgetPassword.call(),
                          child: Text(
                            'فراموشی رمز عبور',
                            style: context.textTheme.bodySmall,
                          ),
                        ),
                        TextButton(
                          onPressed: bloc.gotoSignUpPage.call(),
                          child: Text(
                                  'ایجاد حساب کاربری جدید',
                                  style: context.textTheme.bodySmall,
                                ),
                        ),
                      ],
                    ),
                    4.dpv,
                    ElevatedButton(
                        onPressed: bloc.loginUser.call(), child: bloc.state.isLoading
                        ? const MyLoader(color: Colors.black)
                        : const Text('ورود'))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
