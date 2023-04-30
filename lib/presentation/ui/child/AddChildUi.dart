import 'package:feature/form/validator/LastNameValidator.dart';
import 'package:feature/form/validator/NameValidator.dart';
import 'package:flutter/material.dart';
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
                    MamakTitle(title: 'فرزندان من'),
                    8.dpv,
                    Divider(),
                    8.dpv,
                    FormTitleWithStar(title: 'نام فرزند'),
                    4.dpv,
                    TextFormFieldHelper(
                      label: 'نام فرزند',
                      hint: 'نام فرزند',
                      keyboardType: TextInputType.text,
                      onChangeValue: bloc.onChildFirstNameChange,
                      validator: NameValidator(),
                    ),
                    8.dpv,
                    FormTitleWithStar(title: 'نام خانوادگی'),
                    4.dpv,
                    TextFormFieldHelper(
                      label: 'نام خانوادگی',
                      hint: 'نام خانوادگی',
                      keyboardType: TextInputType.text,
                      onChangeValue: bloc.onChildLastNameChange,
                      validator: LastNameValidator(),
                    ),
                    8.dpv,
                    FormTitleWithStar(title: 'تاریخ تولد'),
                    4.dpv,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropDownFormField(
                            selectedItem: 2,
                            items: positiveIntegers.skip(1).take(30).toList(),
                            name: 'روز',
                            onValueChange: bloc.onDayChange,
                          ),
                        ),
                        2.dph,
                        Expanded(
                          flex: 1,
                          child: DropDownFormField(
                              selectedItem: 10,
                              items: positiveIntegers.skip(1).take(12).toList(),
                              name: 'ماه',
                              onValueChange: bloc.onMonthChange),
                        ),
                        2.dph,
                        Expanded(
                          flex: 1,
                          child: DropDownFormField(
                              selectedItem: 1374,
                              items:
                                  positiveIntegers.skip(1350).take(50).toList(),
                              name: 'سال',
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
                            label: Text('اضافه کردن عکس')),
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
                        child:
                            bloc.uiState.isLoading ? MyLoader() : Text('ثبت'))
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
