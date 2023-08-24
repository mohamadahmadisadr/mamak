import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class EstimateNavigationModel extends HomeNavigationModel{
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.square_list;
  }

  @override
  String name() {
    return 'estimate_workshop'.tr;
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.Estimate;
  }

}