import 'package:core/imagePicker/ImageFileModel.dart';
import 'package:mamak/data/body/child/AddChildBody.dart';
import 'package:mamak/presentation/viewModel/user/ProfileViewModel.dart';
import 'package:shamsi_date/shamsi_date.dart';

class AddChildFormState {
  String childFirstName, childLastName, birtDate, mobileNumber;
  String? childFirstNameError,
      childLastNameError,
      birtDateError,
      mobileNumberError;

  AddChildFormState(
      {this.childFirstName = '',
      this.childFirstNameError,
      this.childLastName = '',
      this.childLastNameError,
      this.birtDate = '',
      this.birtDateError,
      this.mobileNumber = '',
      this.mobileNumberError});

  AddChildBody createBody(ImageFileModel? image) {
    return AddChildBody(
      childFirstName: childFirstName,
      childLastName: childLastName,
      birtDate: birtDate,
      mobileNumber: mobileNumber,
      childPicture: image?.createFileDataBody()
    );
  }
}

class BirthDateTime {
  int day, month, year;

  BirthDateTime({this.day = 0, this.month = 0, this.year = 0});

  DateTime createDate() {
    return Jalali(year, month, day).toDateTime();
  }
}
