import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/register/RegisterUi.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/user/VerificationViewModel.dart';

class VerificationUi extends StatelessWidget {
  const VerificationUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => VerificationViewModel(AppState.idle),
      builder: (bloc, state) {
        return MamakScaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: 16.dpe,
              child: Form(
                key: bloc.formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    8.dpv,
                    MamakTitle(
                      title: 'verify_account'.tr,
                    ),
                    16.dpv,
                    FormTitleWithStar(title: 'confirmation_code'.tr),
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
                    ),
                    16.dpv,
                    ElevatedButton(
                        onPressed: bloc.onSubmitCodeClick,
                        child: bloc.formUiState.isLoading
                            ? const MyLoader()
                            : Text('submit'.tr),),
                    20.dpv,
                    if(bloc.numberData != null)
                      Text(bloc.numberData ?? '')
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
