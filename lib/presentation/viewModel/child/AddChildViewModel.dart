import 'package:core/imagePicker/ImageFileModel.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/formState/child/AddChildFormState.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/child/AddChildUseCase.dart';

class AddChildViewModel extends BaseViewModel {
  AddChildViewModel(super.initialState);

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

  onDayChange(int? day) => birthDateTime.day = day ?? 0;

  onMonthChange(int? month) => birthDateTime.month = month ?? 0;

  onYearChange(int? year) => birthDateTime.year = year ?? 0;

  void submit() {
    if (birthDateTime.day == 0 ||
        birthDateTime.month == 0 ||
        birthDateTime.year == 0) {
      messageService.showSnackBar('تاریخ تولد را وارد کنید.');
      return;
    }
    // if(selectedImage == null){
    //   messageService.showSnackBar('لطفا یک عکس اضافه کنید');
    // }
    if (formState.currentState?.validate() == true) {
      _formState.birtDate = birthDateTime.createDate().toIso8601String();
      AddChildUseCase().invoke(MyFlow(flow: (appState) {
        if(appState.isFailed){
          messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        }
        if (appState.isSuccess) {
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

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  void addImage() {
    getImage();
  }
}
