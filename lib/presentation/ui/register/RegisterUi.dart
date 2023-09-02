import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/core/form/validator/LastNameValidator.dart';
import 'package:mamak/core/form/validator/MobileValidator.dart';
import 'package:mamak/core/form/validator/NameValidator.dart';
import 'package:mamak/core/locale/locale_extension.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakLogo.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/PasswordFieldHelper.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/register/text_with_link.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/user/SignUpViewModel.dart';
import 'package:url_launcher/url_launcher.dart'
if (dart.library.html) 'package:mamak/presentation/ui/recaptcha/recaptcha.dart';
class RegisterUi extends StatelessWidget {
  const RegisterUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => SignUpViewModel(AppState.idle),
      builder: (bloc, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Form(
              key: bloc.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  20.dpv,
                  Text(
                    "sign_up".tr,
                    style: context.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  20.dpv,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MamakLogo(),
                    ],
                  ),
                  20.dpv,
                  if (Get.locale.isPersian)
                    FormTitleWithStar(title: "mobile".tr),
                  if (Get.locale.isPersian) 4.dpv,
                  if (Get.locale.isPersian)
                    TextFormFieldHelper(
                      label: "mobile".tr,
                      hint: "mobile".tr,
                      keyboardType: TextInputType.phone,
                      onChangeValue: bloc.onMobileChange,
                      validator: MobileValidator(),
                    ),
                  10.dpv,
                  Text(
                    'email'.tr,
                    style: context.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  4.dpv,
                  TextFormFieldHelper(
                    label: 'email'.tr,
                    hint: 'email'.tr,
                    keyboardType: TextInputType.emailAddress,
                    onChangeValue: bloc.onEmailChange,
                    // validator: EmailValidator(),
                  ),
                  10.dpv,
                  FormTitleWithStar(title: "mothers_name".tr),
                  4.dpv,
                  TextFormFieldHelper(
                    label: "mothers_name".tr,
                    hint: "mothers_name".tr,
                    keyboardType: TextInputType.text,
                    onChangeValue: bloc.onFirstNameChange,
                    validator: NameValidator(),
                  ),
                  10.dpv,
                  FormTitleWithStar(title: "mothers_family".tr),
                  4.dpv,
                  TextFormFieldHelper(
                    label: "mothers_family".tr,
                    hint: "mothers_family".tr,
                    keyboardType: TextInputType.text,
                    onChangeValue: bloc.onLastNameChange,
                    validator: LastNameValidator(),
                  ),
                  10.dpv,
                  // const FormTitleWithStar(title: "استان"),
                  // 4.dpv,
                  // ConditionalUI<List<ProvinceItem>>(
                  // skeleton: LocationItemShimmer(),
                  //   state: bloc.pState,
                  //   onSuccess: (provinces) {
                  //     return DropDownFormField(
                  //       selectedItem: bloc.selectedProvince,
                  //       items: provinces.map((e) => DropDownModel(data: e, name: e.provinceName ?? '')).toList(),
                  //       name: 'استان',
                  //       onValueChange: bloc.onProvinceChange,
                  //     );
                  //   },
                  // ),
                  // 10.dpv,
                  // const FormTitleWithStar(title: "شهر"),
                  // 4.dpv,
                  // ConditionalUI<List<CityItem>>(
                  //   skeleton: LocationItemShimmer(),
                  //   state: bloc.cState,
                  //   onSuccess: (cities) {
                  //     if (cities.isNotEmpty) {
                  //       return DropDownFormField(
                  //         selectedItem: bloc.selectedCity,
                  //         items: cities.map((e) => DropDownModel(data: e, name: e.cityName ?? '')).toList(),
                  //         name: 'شهر',
                  //         onValueChange: bloc.onCityChange,
                  //       );
                  //     }
                  //     return const EmptyPageUI();
                  //   },
                  // ),
                  // if(bloc.cState == AppState.idle) Container(
                  //   alignment: Alignment.center,
                  //   padding: 24.dpe,
                  //   margin: 8.dpe,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade200,
                  //     borderRadius: 8.bRadius,
                  //   ),
                  // ),
                  // 10.dpv,
                  FormTitleWithStar(title: "password".tr),
                  4.dpv,
                  PasswordFieldHelper(onChangeValue: bloc.onPasswordChange),
                  10.dpv,
                  FormTitleWithStar(title: "confirm_password".tr),
                  4.dpv,
                  PasswordFieldHelper(
                    onChangeValue: bloc.onConfirmPasswordChange,
                    isRePsw: true,
                  ),
                  20.dpv,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: bloc.gotoLoginPage.call(),
                          child: Text(
                            'already_signup'.tr,
                            style: context.textTheme.caption,
                          ))
                    ],
                  ),
                  // 20.dpv,
                  // const FormTitleWithStar(title: 'اشتراک'),
                  // 4.dpv,
                  // ExamTimePickerFormField(
                  //   state: bloc.subscribesState,
                  //   onValueChange: bloc.onItemChanged.call(),
                  //   selectedItem: bloc.formState.subscribeId,
                  // ),
                  10.dpv,
                  TextWithLink(text: 'policy_msg_lr'.tr),
                  20.dpv,
                  ElevatedButton(
                      onPressed: bloc.register.call(),
                      child: bloc.uiState.isLoading
                          ? const MyLoader(color: Colors.black)
                          : Text("next_step".tr)),
                  // if (kIsWeb)
                    // SizedBox(
                    //     width: 100,
                    //     height: 200,
                    //     child: Recaptcha(
                    //       onChangeToken: bloc.onChangeToken,
                    //     ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
}

class FormTitleWithStar extends StatelessWidget {
  const FormTitleWithStar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const StarText(),
      ],
    );
  }
}

class StarText extends StatelessWidget {
  const StarText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("*",
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.red));
  }
}
