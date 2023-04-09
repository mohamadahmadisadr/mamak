import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class MoreNavigationModel extends HomeNavigationModel {
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.chevron_down;
  }

  @override
  String name() {
    return '';
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.More;
  }
}
