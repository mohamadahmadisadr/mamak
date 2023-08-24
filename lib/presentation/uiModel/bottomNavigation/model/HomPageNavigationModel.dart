import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class HomePageNavigationModel extends HomeNavigationModel {
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.home;
  }

  @override
  String name() {
    return 'home'.tr;
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.Home;
  }
}
