import 'package:feature/form/validator/NameValidator.dart';
import 'package:feature/form/validator/login/EmailValidator.dart';
import 'package:feature/form/validator/login/MobileValidator.dart';
import 'package:flutter/material.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/app/ContactUsViewModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

import 'MamakMap.dart';

class ContactUsUi extends StatelessWidget {
  const ContactUsUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ContactUsViewModel(AppState.idle),
      builder: (bloc, state) {
        return MamakScaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: 16.dpe,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  8.dpv,
                  const MamakTitle(
                    title: 'تماس با ما',
                  ),
                  32.dpv,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on),
                      4.dph,
                      const Text(
                          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ')
                    ],
                  ),
                  8.dpv,
                  Container(
                    padding: 16.dpe,
                    decoration: BoxDecoration(
                      borderRadius: 8.bRadius,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.call),
                        4.dph,
                        const Text(
                          '2222222',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  16.dpv,
                  ClipRRect(
                    borderRadius: 8.bRadius,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: 8.bRadius),
                      height: 300,
                      child: const MamakMapUi(),
                    ),
                  ),
                  ContactUsFormUi(
                    formKey: bloc.formKey,
                    onNameChange: bloc.onNameChange,
                    onEmailChange: bloc.onEmailChange,
                    onMobileChange: bloc.onMobileChange,
                    onSubjectChange: bloc.onSubChange,
                    onTextChange: bloc.onTextChange,
                  ),
                  ElevatedButton(
                      onPressed: bloc.submitForm,
                      child: bloc.state.isLoading
                          ? const MyLoader()
                          : const Text('ارسال پیام')),
                  16.dpv
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ContactUsFormUi extends StatelessWidget {
  ContactUsFormUi({
    Key? key,
    required this.formKey,
    required this.onNameChange,
    required this.onEmailChange,
    required this.onMobileChange,
    required this.onSubjectChange,
    required this.onTextChange,
  }) : super(key: key);
  GlobalKey<FormState> formKey;
  Function(String) onNameChange,
      onEmailChange,
      onMobileChange,
      onSubjectChange,
      onTextChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.dpev,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormFieldHelper(
              label: 'نام',
              hint: 'نام',
              keyboardType: TextInputType.text,
              onChangeValue: onNameChange,
              validator: NameValidator(),
            ),
            8.dpv,
            TextFormFieldHelper(
              label: 'ایمیل',
              hint: 'ایمیل',
              keyboardType: TextInputType.emailAddress,
              onChangeValue: onEmailChange,
              validator: EmailValidator(),
            ),
            8.dpv,
            TextFormFieldHelper(
              label: 'شماره تماس',
              hint: 'شماره تماس',
              keyboardType: TextInputType.number,
              onChangeValue: onMobileChange,
              validator: MobileValidator(),
            ),
            8.dpv,
            TextFormFieldHelper(
                label: 'موضوع پیام',
                hint: 'موضوع پیام',
                keyboardType: TextInputType.text,
                onChangeValue: onSubjectChange),
            8.dpv,
            SizedBox(
              height: 200,
              child: TextFormFieldHelper(
                label: 'متن پیام',
                hint: 'متن پیام',
                keyboardType: TextInputType.text,
                onChangeValue: onTextChange,
                expand: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
