import 'package:core/Notification/MyNotification.dart';
import 'package:core/imagePicker/ImageFileModel.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/core/locale/locale_extension.dart';
import 'package:mamak/presentation/state/formState/child/AddChildFormState.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/child/AddChildUseCase.dart';

class AddChildViewModel extends BaseViewModel {
  AddChildViewModel(super.initialState) {
    initDate();
  }

  void initDate(){
    birthDateTime.day = 2;
    birthDateTime.month = 10;
    birthDateTime.year = Get.locale == const Locale('fa','IR') ? 1398 : 2016;
  }

  final MyNotification _notification = GetIt.I.get();
  AppState uiState = AppState.idle;

  ImageFileModel? selectedImage;
  final MyImagePicker _myImagePicker = GetIt.I.get();

  final AddChildFormState _formState = AddChildFormState();
  BirthDateTime birthDateTime = BirthDateTime();
  final formState = GlobalKey<FormState>();
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  onChildFirstNameChange(String firstName) =>
      _formState.childFirstName = firstName;

  onChildLastNameChange(String lastName) => _formState.childLastName = lastName;

  onDayChange(dynamic day) => birthDateTime.day = day ?? 0;

  onMonthChange(dynamic month) => birthDateTime.month = month ?? 0;

  onYearChange(dynamic year) => birthDateTime.year = year ?? 0;

  void submit() {
    if (birthDateTime.day == 0 ||
        birthDateTime.month == 0 ||
        birthDateTime.year == 0) {
      messageService.showSnackBar('enter_date'.tr);
      return;
    }
    // if(selectedImage == null){
    //   messageService.showSnackBar('لطفا یک عکس اضافه کنید');
    // }
    if (formState.currentState?.validate() == true) {
      _formState.birtDate = Get.locale.isPersian ? birthDateTime.createPersianDate().toIso8601String() : birthDateTime.createDate().toIso8601String();
      AddChildUseCase().invoke(MyFlow(flow: (appState) {
        if (appState.isFailed) {
          messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        }
        if (appState.isSuccess) {
          _notification.publish('GetChildViewModel', true);
          _notification.publish('NewHomeViewModel', true);
          _notification.publish(
              'MainViewModel', HomeNavigationEnum.WorkShops.value);
          _navigationServiceImpl.pop();
        }
        uiState = appState;
        refresh();
      }), data: _formState.createBody(selectedImage));
    }
  }

  void getImage() async {
    selectedImage = await _myImagePicker.pickImage();
    selectedImage?.Id = '00000000-0000-0000-0000-000000000000';
    if (selectedImage != null) {
      refresh();
    }
  }


  void addImage() {
    getImage();
  }
}
