import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class IntroductionNavigationModel extends HomeNavigationModel {
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return CupertinoIcons.person_3_fill;
  }

  @override
  String name() {
    return 'intruduce_mamak'.tr;
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.Introduction;
  }
}
