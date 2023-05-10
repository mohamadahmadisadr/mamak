import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class SubscriptionNavigationModel extends HomeNavigationModel{
  String badgeContainer = '';

  SubscriptionNavigationModel() {
    badgeContainer = getBadge;
  }

  @override
  String badge() {
    return badgeContainer;
  }

  void changeBadge(String newBadge) {
    badgeContainer = newBadge;
  }

  @override
  IconData icon() {
    return CupertinoIcons.doc_person;
  }

  @override
  String name() {
    return 'خرید  اشتراک';
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.Subscription;
  }

}