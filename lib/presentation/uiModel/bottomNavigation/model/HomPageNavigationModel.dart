import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class HomePageNavigationModel extends HomeNavigationModel{
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
    return 'خانه';
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.Home;
  }

}