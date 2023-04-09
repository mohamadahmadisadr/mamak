import 'package:feature/form/validator/login/MobileValidator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/presentation/ui/main/MamakLogo.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/PasswordFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          20.dpv,
          const MamakLogo(),
          20.dpv,
          Text("شماره همراه",style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),),
          4.dpv,
          TextFormFieldHelper(
            label: "شماره همراه",
            hint: "شماره همراه",
            keyboardType: TextInputType.phone,
            onChangeValue: (value) {},
            validator: MobileValidator(),
          ),
          10.dpv,
          Text("رمز عبور",style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),),
          4.dpv,
          PasswordFieldHelper(onChangeValue: (value){}),
          20.dpv,
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){}, child: Text('فراموشی رمز عبور',style: context.textTheme.caption,)),
              TextButton(onPressed: (){}, child: Text('ایجاد جساب کاربری جدید',style: context.textTheme.caption,)),
            ],
          ),
          4.dpv,
          ElevatedButton(onPressed: (){}, child: const Text('ورود'))
        ],
      ),
    );
  }
}
