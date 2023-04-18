import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class WorkBookNavigationModel extends HomeNavigationModel{
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.square_list_fill;
  }

  @override
  String name() {
    return 'کارنامه';
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.Workbook;
  }

}