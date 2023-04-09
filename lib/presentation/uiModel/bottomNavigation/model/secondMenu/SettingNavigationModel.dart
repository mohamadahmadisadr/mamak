import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class SettingNavigationModel extends HomeNavigationModel{
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.settings;
  }

  @override
  String name() {
    return 'تنظیمات برنامه';
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.Setting;
  }

}