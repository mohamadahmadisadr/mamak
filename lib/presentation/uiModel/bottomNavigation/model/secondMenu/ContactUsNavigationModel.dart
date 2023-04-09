import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class ContactUsNavigationModel extends HomeNavigationModel{
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.phone_down_circle;
  }

  @override
  String name() {
    return 'تماس با ما';
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.ContactUs;
  }

}