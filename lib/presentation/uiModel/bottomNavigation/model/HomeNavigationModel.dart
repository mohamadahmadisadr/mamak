import 'package:flutter/cupertino.dart';
import 'package:mamak/presentation/ui/Home/HomeUI.dart';
import 'package:mamak/presentation/ui/Introduction/IntroductionUI.dart';
import 'package:mamak/presentation/ui/contactUs/ContactUsUi.dart';
import 'package:mamak/presentation/ui/more/MoreNewUi.dart';
import 'package:mamak/presentation/ui/subscription/SubscriptionUI.dart';
import 'package:mamak/presentation/ui/user/profile/ProfileUi.dart';
import 'package:mamak/presentation/ui/workBook/MothersWorkBookTabsUi.dart';
import 'package:mamak/presentation/ui/workBook/WorkBookUi.dart';
import 'package:mamak/presentation/ui/workShop/MyWorkShops.dart';

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
  Workbook(4),
  SecondMore(5),
  ContactUs(6),
  Setting(7),
  WorkShops(9),
  Estimate(10),
  Profile(11);

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
        return HomeNavigationEnum.Workbook;
      case 5:
        return HomeNavigationEnum.SecondMore;
      case 6:
        return HomeNavigationEnum.ContactUs;
      case 11:
        return HomeNavigationEnum.Profile;
      case 9:
        return HomeNavigationEnum.WorkShops;
      default:
        return HomeNavigationEnum.Home;
    }
  }
}

extension HomeNavigationEnumExtension on HomeNavigationEnum {
  Widget getPage() {
    print(this);
    print(this.value);
    switch (this) {
      case HomeNavigationEnum.Subscription:
        return const SubscriptionUI();
      case HomeNavigationEnum.Introduction:
        return const IntroductionUI();
      case HomeNavigationEnum.More:
        return const SizedBox.shrink();
      case HomeNavigationEnum.Home:
        return const HomeUI();
      case HomeNavigationEnum.Workbook:
        return const WorkBookUi();
      case HomeNavigationEnum.Profile:
        return const ProfileUi();
      case HomeNavigationEnum.WorkShops:
        return const MyWorkShops();
      case HomeNavigationEnum.ContactUs:
        return const ContactUsUi();
        case HomeNavigationEnum.SecondMore:
        return const MoreHomeNewUi();
      default:
        return const SizedBox.shrink();
    }
  }
}
