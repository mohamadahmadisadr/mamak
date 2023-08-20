import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/presentation/state/NetworkExtensions.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakLogo.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/PasswordFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/register/RegisterUi.dart';
import 'package:mamak/presentation/viewModel/user/ChangePasswordViewModel.dart';

class ChangePasswordUi extends StatelessWidget {
  const ChangePasswordUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ChangePasswordViewModel(AppState.idle),
      builder: (bloc, state) {
        return MamakScaffold(
          body: Padding(
            padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Form(
              key: bloc.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  20.dpv,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MamakLogo(width: 180),
                    ],
                  ),
                  20.dpv,
                  Text(
                    'تغییر رمز',
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  20.dpv,
                  const FormTitleWithStar(
                    title: "رمز عبور قبلی",
                  ),
                  4.dpv,
                  PasswordFieldHelper(
                      onChangeValue: bloc.onCurrentPasswordChange),
                  10.dpv,
                  const FormTitleWithStar(
                    title: "رمز عبور جدید",
                  ),
                  4.dpv,
                  PasswordFieldHelper(onChangeValue: bloc.onPasswordChange),
                  10.dpv,
                  const FormTitleWithStar(
                    title: "تکرار رمز عبور جدید",
                  ),
                  4.dpv,
                  PasswordFieldHelper(
                      onChangeValue: bloc.onConfirmPasswordChange),
                  20.dpv,
                  ElevatedButton(
                      onPressed: bloc.onSubmitClick,
                      child: bloc.state.isLoading
                          ? const MyLoader(color: Colors.black)
                          : const Text('ثبت'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
