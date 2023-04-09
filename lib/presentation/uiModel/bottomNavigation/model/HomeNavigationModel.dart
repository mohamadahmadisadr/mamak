import 'package:flutter/cupertino.dart';
import 'package:mamak/presentation/ui/Home/HomeUI.dart';
import 'package:mamak/presentation/ui/Introduction/IntroductionUI.dart';
import 'package:mamak/presentation/ui/estimate/EstimateUI.dart';
import 'package:mamak/presentation/ui/subscription/SubscriptionUI.dart';

abstract class HomeNavigationModel {
  String name();

  String badge();

  String get getName => name();

  String get getBadge => badge();

  IconData icon();

  HomeNavigationEnum value();

  IconData get getIcon => icon();

  int get index => value().value;
}

enum HomeNavigationEnum {
  Subscription(0),
  Introduction(1),
  More(2),
  Home(3),
  Estimate(4),
  SecondMore(5),
  ContactUs(6),
  Setting(7),
  WorkBook(8),
  WorkbookEstimate(9);

  final int value;

  const HomeNavigationEnum(this.value);
}

extension HomeNavigationExtension on int {
  HomeNavigationEnum toHomeNavigationEnum() {
    switch (this) {
      case 0:
        return HomeNavigationEnum.Subscription;
      case 1:
        return HomeNavigationEnum.Introduction;
      case 2:
        return HomeNavigationEnum.More;
      case 3:
        return HomeNavigationEnum.Home;
      case 4:
        return HomeNavigationEnum.Estimate;
      default:
        return HomeNavigationEnum.Home;
    }
  }
}

extension HomeNavigationEnumExtension on HomeNavigationEnum {
  Widget getPage() {
    switch (this) {
      case HomeNavigationEnum.Subscription:
        return const SubscriptionUI();
      case HomeNavigationEnum.Introduction:
        return const IntroductionUI();
      case HomeNavigationEnum.More:
        return const SizedBox();
      case HomeNavigationEnum.Home:
        return const HomeUI();
      case HomeNavigationEnum.Estimate:
        return const EstimateUI();
      default:
        return const SizedBox.shrink();
    }
  }
}
