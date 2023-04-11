import 'package:feature/form/validator/login/MobileValidator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/register/RegisterUi.dart';

class ForgetPasswordUi extends StatelessWidget {
  const ForgetPasswordUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            20.dpv,
            Text(
              "فراموشی کلمه عبور",
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            20.dpv,
            const FormTitleWithStar(title: "شماره همراه یا ایمیل"),
            20.dpv,
            TextFormFieldHelper(
              label: "شماره همراه یا ایمیل",
              hint: "شماره همراه یا ایمیل",
              keyboardType: TextInputType.phone,
              onChangeValue: (value) {},
              validator: MobileValidator(),
            ),
            10.dpv,
            Text(
              'کد تایید ارسال شد',
              textAlign: TextAlign.center,
            ),
            10.dpv,
            Text('کد تایید را وارد کنید'),
            4.dpv,
            TextFormFieldHelper(
              label: "",
              hint: "",
              keyboardType: TextInputType.number,
              onChangeValue: (value) {},
              labelStyle: const TextStyle(letterSpacing: 30, fontSize: 25),
              textAlign: TextAlign.center,
              maxLength: 4,
            ),
            10.dpv,
          ],
        ),
      ),
    );
  }
}
