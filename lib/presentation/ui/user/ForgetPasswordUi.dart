// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mamak/config/uiCommon/WidgetSize.dart';
// import 'package:mamak/presentation/ui/main/CubitProvider.dart';
// import 'package:mamak/presentation/ui/main/UiExtension.dart';
//
// class ForgetPasswordUi extends StatelessWidget {
//   const ForgetPasswordUi({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CubitProvider(
//       create: (context) => SignUpViewModel(AppState.idle),
//       builder: (bloc, state) {
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
//             child: Form(
//               key: bloc.formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   20.dpv,
//                   Text(
//                     "فراموشی",
//                     style: context.textTheme.titleSmall
//                         ?.copyWith(fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                   const FormTitleWithStar(title: "شماره همراه"),
//                   4.dpv,
//                   TextFormFieldHelper(
//                     label: "شماره همراه",
//                     hint: "شماره همراه",
//                     keyboardType: TextInputType.phone,
//                     onChangeValue: bloc.onMobileChange,
//                     validator: MobileValidator(),
//                   ),
//                   10.dpv,
//                   const FormTitleWithStar(title: "نام"),
//                   4.dpv,
//                   TextFormFieldHelper(
//                     label: "نام",
//                     hint: "نام",
//                     keyboardType: TextInputType.text,
//                     onChangeValue: bloc.onFirstNameChange,
//                     validator: NameValidator(),
//                   ),
//                   10.dpv,
//                   const FormTitleWithStar(title: "نام خانوادگی"),
//                   4.dpv,
//                   TextFormFieldHelper(
//                     label: "نام خانوادگی",
//                     hint: "نام خانوادگی",
//                     keyboardType: TextInputType.text,
//                     onChangeValue: bloc.onLastNameChange,
//                     validator: LastNameValidator(),
//                   ),
//                   10.dpv,
//                   const FormTitleWithStar(title: "رمز عبور"),
//                   4.dpv,
//                   PasswordFieldHelper(onChangeValue: bloc.onPasswordChange),
//                   10.dpv,
//                   const FormTitleWithStar(title: "تکرار رمز عبور"),
//                   4.dpv,
//                   PasswordFieldHelper(
//                       onChangeValue: bloc.onRePswChange, isRePsw: true),
//                   20.dpv,
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                           onPressed: bloc.gotoLoginPage.call(),
//                           child: Text(
//                             'حساب کاربری دارم',
//                             style: context.textTheme.caption,
//                           ))
//                     ],
//                   ),
//                   20.dpv,
//                   const FormTitleWithStar(title: 'اشتراک'),
//                   4.dpv,
//                   ExamTimePickerFormField(
//                     state: bloc.subscribesState,
//                     onValueChange: bloc.onItemChanged.call(),
//                     selectedItem: bloc.formState.subscribeId,
//                   ),
//                   20.dpv,
//                   ElevatedButton(
//                       onPressed: bloc.register.call(),
//                       child: bloc.state.isLoading
//                           ? const MyLoader(color: Colors.black)
//                           : const Text('مرحله بعد'))
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//
//   }
// }
