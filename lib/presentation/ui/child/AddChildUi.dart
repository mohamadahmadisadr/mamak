import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/core/form/validator/LastNameValidator.dart';
import 'package:mamak/core/form/validator/NameValidator.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/DropDownFormField.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/register/RegisterUi.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/child/AddChildViewModel.dart';
import 'package:mamak/presentation/viewModel/user/ProfileViewModel.dart';

class AddChildUi extends StatelessWidget {
  const AddChildUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => AddChildViewModel(AppState.idle),
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
                    16.dpv,
                    MamakTitle(title: 'my_chils'.tr), //my_childs
                    8.dpv,
                    Divider(),
                    8.dpv,
                    FormTitleWithStar(title: 'childs_name'.tr), //childs_name
                    4.dpv,
                    TextFormFieldHelper(
                      label: 'childs_name'.tr,
                      hint: 'childs_name'.tr,
                      keyboardType: TextInputType.text,
                      onChangeValue: bloc.onChildFirstNameChange,
                      validator: NameValidator(),
                    ),
                    8.dpv,
                    FormTitleWithStar(title: 'last_name'.tr),
                    4.dpv,
                    TextFormFieldHelper(
                      label: 'last_name'.tr,
                      hint: 'last_name'.tr,
                      keyboardType: TextInputType.text,
                      onChangeValue: bloc.onChildLastNameChange,
                      validator: LastNameValidator(),
                    ),
                    8.dpv,
                    FormTitleWithStar(title: 'birthdate'.tr),
                    4.dpv,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropDownFormField(
                            selectedItem:
                                DropDownModel(data: 2, name: 2.toString()),
                            items: positiveIntegers
                                .skip(1)
                                .take(31)
                                .toList()
                                .map((e) =>
                                    DropDownModel(data: e, name: e.toString()))
                                .toList(),
                            name: 'day'.tr,
                            onValueChange: bloc.onDayChange,
                          ),
                        ),
                        2.dph,
                        Expanded(
                          flex: 1,
                          child: DropDownFormField(
                              selectedItem:
                                  DropDownModel(data: 10, name: 10.toString()),
                              items: positiveIntegers
                                  .skip(1)
                                  .take(12)
                                  .toList()
                                  .map((e) => DropDownModel(
                                      data: e, name: e.toString()))
                                  .toList(),
                              name: 'month'.tr,
                              onValueChange: bloc.onMonthChange),
                        ),
                        2.dph,
                        Expanded(
                          flex: 1,
                          child: DropDownFormField(
                              selectedItem: DropDownModel(
                                  data: Get.locale == const Locale('fa', 'IR')
                                      ? 1398
                                      : 2016,
                                  name: 1398.toString()),
                              items: positiveIntegers
                                  .skip(Get.locale == const Locale('fa', 'IR')
                                      ? 1395
                                      : 2016)
                                  .take(5)
                                  .toList()
                                  .map((e) => DropDownModel(
                                      data: e, name: e.toString()))
                                  .toList(),
                              name: 'year'.tr,
                              onValueChange: bloc.onYearChange),
                        ),
                      ],
                    ),
                    8.dpv,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                            onPressed: bloc.addImage,
                            icon: Icon(Icons.attachment_sharp),
                            label: Text('add_photo'.tr)),
                        if (bloc.selectedImage != null)
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.memory(
                              bloc.selectedImage!.getFileFormBase64(),
                              fit: BoxFit.fill,
                            ),
                          )
                      ],
                    ),
                    8.dpv,
                    ElevatedButton(
                        onPressed: bloc.submit,
                        child: bloc.uiState.isLoading
                            ? MyLoader()
                            : Text('submit'.tr))
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

Iterable<int> get positiveIntegers sync* {
  int i = 0;
  while (true) {
    yield i++;
  }
}
