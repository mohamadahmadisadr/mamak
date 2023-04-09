import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class WorkBookEstimateNavigationModel extends HomeNavigationModel{
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.list_bullet_below_rectangle;
  }

  @override
  String name() {
    return 'گزارش ارزیابی';
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.WorkbookEstimate;
  }

}