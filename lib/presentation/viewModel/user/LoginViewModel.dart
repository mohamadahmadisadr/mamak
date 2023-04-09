// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
// import 'package:kanooniha/core/Logger.dart';
// import 'package:kanooniha/data/bases/baseViewModel.dart';
// import 'package:kanooniha/data/serializer/RegisterResponse.dart';
// import 'package:kanooniha/data/serializer/User.dart';
// import 'package:kanooniha/domain/network/NetworkExtensions.dart';
// import 'package:rxdart/rxdart.dart';
//
// import '../../../common/appCommons/appRoutes.dart';
// import '../../../common/user/UserSessionConst.dart';
// import '../../../core/flow/MyFlow.dart';
// import '../../../core/navigationService/NavigationService.dart';
// import '../../../data/body/gift/GetPopupMessagesResponse.dart';
// import '../../../domain/formState/login/LoginFormState.dart';
// import '../../../domain/localSession/LocalSessionImpl.dart';
// import '../../../domain/useCase/user/GetPopupMessagesUseCase.dart';
// import '../../../domain/useCase/user/LoginUseCase.dart';
// import '../../ui/dialog/GiftMessageDialogUI.dart';
//
// class LoginViewModel extends BaseViewModel {
//   var navigationService = GetIt.I.get<NavigationServiceImpl>();
//   var sessionManager = GetIt.I.get<LocalSessionImpl>();
//   var formKey = GlobalKey<FormState>();
//   var loginFormState = BehaviorSubject<LoginFormState>();
//   late final loginUseCase =
//       LoginUseCase.initFormState(loginFormState: loginFormState.value);
//   final _getPopupMessagesUseCase = GetPopupMessagesUseCase();
//
//   LoginViewModel(super.initialState) {
//     loginFormState.value = LoginFormState();
//     getExtra();
//   }
//
//   void getExtra() {
//     Logger.d('getting extra');
//     var modal = Get.arguments;
//     Logger.d(modal.toString());
//     if (modal is User && modal.mobile != null) {
//       Logger.d(modal.mobile.toString());
//       loginFormState.value.mobile = modal.mobile!;
//     }
//   }
//
//   bool get isValid => formKey.currentState?.validate() == true;
//
//   Function(String) get onMobileChange =>
//       (value) => loginFormState.value.mobile = value;
//
//   Function(String) get onPasswordChange =>
//       (value) => loginFormState.value.password = value;
//
//   @override
//   Future<void> close() {
//     return super.close();
//   }
//
//   void getGiftMessages() {
//     _getPopupMessagesUseCase.invoke(MyFlow(flow: (appState) {
//       updateState(appState);
//       if(appState.isSuccess && appState.getData is GetPopupMessagesResponse){
//         var popMsg = (appState.getData as GetPopupMessagesResponse).data?.popupMessage;
//         Get.dialog(GiftMessageDialogUI(message: popMsg!),barrierDismissible: false);
//       }else if(appState.isFailed){
//         navigationService.replaceTo(AppRoutes.home);
//       }
//     }));
//   }
//
//   Function() loginUser() {
//     return () {
//       if (isValid) {
//         loginUseCase.invoke(
//           MyFlow(flow: (state) {
//             postResult(state);
//             if (state.isSuccess && state.getData is RegisterResponse) {
//               var registerResponse = state.getData as RegisterResponse;
//               var user = registerResponse.data?.user;
//               if (user?.isValid == true) {
//                 if (user != null) {
//                   saveUserData(user);
//                 }
//                 Logger.d("${user?.firstName} ${user?.lastName} is valid");
//                 getGiftMessages();
//               } else {
//                 Logger.d(
//                     "${user?.firstName} ${user?.lastName} ${registerResponse.data?.activationCode} is inValid");
//                 user?.setCode =
//                     registerResponse.data?.activationCode?.toString();
//                 navigationService.replaceTo(AppRoutes.verification, user);
//               }
//             } else if (state.isFailed) {
//               messageService.showSnackBar(state.getErrorModel?.message ?? '');
//             }
//           }),
//         );
//       }
//     };
//   }
//
//   Future<bool> saveUserData(User user) {
//     var map = {
//       UserSessionConst.id: user.id?.toString() ?? '0',
//       UserSessionConst.fullName: '${user.firstName} ${user.lastName}',
//       UserSessionConst.paye: user.groupName ?? '',
//       UserSessionConst.nationalCode: user.nationalCode?.toString() ?? '',
//       UserSessionConst.mobile: user.mobile ?? '',
//     };
//     sessionManager.insertData(map);
//     return Future.value(true);
//   }
//
//   Function() pushToRegister() =>
//       () => navigationService.replaceTo(AppRoutes.register);
//
//   Function() pushToForgetPassword() =>
//       () => navigationService.navigateTo(AppRoutes.forgetPassword);
//
//   Function() pushToVerificationPage(User user) =>
//       () => navigationService.replaceTo(AppRoutes.register, user);
// }
