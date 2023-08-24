import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class ExtraNavigationModel extends HomeNavigationModel{
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return Icons.more_horiz;
  }

  @override
  String name() {
    return 'more'.tr;
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.SecondMore;
  }

}