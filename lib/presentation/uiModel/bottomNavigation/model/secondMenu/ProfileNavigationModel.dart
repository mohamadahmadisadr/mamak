import 'package:flutter/cupertino.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class ProfileNavigationModel extends HomeNavigationModel {
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.person;
  }

  @override
  String name() {
    return 'پروفایل';
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.Profile;
  }
}
