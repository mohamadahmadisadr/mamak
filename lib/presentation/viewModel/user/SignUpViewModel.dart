import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/formState/user/RegisterFormState.dart';
import 'package:mamak/presentation/ui/main/DropDownFormField.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/location/city_use_case.dart';
import 'package:mamak/useCase/location/provinces_use_case.dart';
import 'package:mamak/useCase/subscribe/GetSubscribeUseCase.dart';
import 'package:mamak/useCase/user/SignUpUseCase.dart';

class SignUpViewModel extends BaseViewModel {
  NavigationServiceImpl navigationServiceImpl =
      GetIt.I.get<NavigationServiceImpl>();

  var formKey = GlobalKey<FormState>();
  RegisterFormState formState = RegisterFormState();

  AppState uiState = AppState.idle;
  AppState pState = AppState.idle;
  AppState cState = AppState.idle;
  DropDownModel? selectedProvince;
  DropDownModel? selectedCity;

  SignUpViewModel(super.initialState) {
    getRecaptchaToken();
    // fetchSubscribes();
    // fetchProvinces();
  }

  AppState subscribesState = AppState.idle;

  void fetchSubscribes() {
    GetSubscribeUseCase().invoke(
      MyFlow(
        flow: (subscribesState) {
          this.subscribesState = subscribesState;
        },
      ),
    );
  }

  void fetchCityByProvinceId(String provinceId) {
    CityUseCase().invoke(MyFlow(
      flow: (appState) {
        cState = appState;
        refresh();
      },
    ), data: provinceId);
  }

  bool get isValid => formKey.currentState?.validate() == true;

  Function(String) get onMobileChange => (value) => formState.mobile = value;

  Function(String) get onFirstNameChange =>
      (value) => formState.firstName = value;

  Function(String) get onLastNameChange =>
      (value) => formState.lastName = value;

  Function(String) get onPasswordChange =>
      (value) => formState.password = value;

  Function(String) get onConfirmPasswordChange =>
      (value) => formState.confirmPassword = value;

  Function(String) get onEmailChange => (value) => formState.email = value;

  // Function(bool) get onTermsChange => (value) => formState.terms = value;

  Function() register() {
    return () {
      if (isValid) {
        if (formState.password != formState.confirmPassword) {
          messageService.showSnackBar('گذرواژه ها باید یکی باشند');
          return;
        }

        SignUpUseCase().invoke(MyFlow(flow: (appState) {
          if (appState.isSuccess) {
            navigationServiceImpl.replaceTo(
                AppRoute.verification, formState.mobile);
          }
          if (appState.isFailed) {
            messageService.showSnackBar(appState.getErrorModel?.message ?? '');
          }
          uiState = appState;
          refresh();
        }), data: formState.getBody());
      }
    };
  }

  void fetchProvinces() {
    ProvinceUseCase().invoke(MyFlow(flow: (appState) {
      pState = appState;
      refresh();
    }));
  }

  Function(int?) onItemChanged() {
    return (value) {
      if (value != null) {
        // formState.subscribeId = value;
      }
    };
  }

  Function() gotoLoginPage() => () {
        navigationServiceImpl.replaceTo(AppRoute.login);
      };

  onProvinceChange(dynamic newProvince) {
    selectedCity = null;
    selectedProvince =
        DropDownModel(data: newProvince, name: newProvince?.provinceName ?? '');
    if (newProvince != null && newProvince.id != null) {
      fetchCityByProvinceId(newProvince.id.toString());
    }
    refresh();
  }

  onCityChange(dynamic newCity) {
    selectedCity = DropDownModel(data: newCity, name: newCity?.cityName ?? '');
    refresh();
  }

  void getRecaptchaToken() async {
    // var token = await GetIt.I.get<RecaptchaSolver>().generateToken();
    // Logger.d('generated token is $token');
  }
}
