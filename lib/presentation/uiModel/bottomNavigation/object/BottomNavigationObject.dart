import 'package:mamak/presentation/uiModel/bottomNavigation/model/EstimateNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomPageNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/IntroductionNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/MoreNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/SubscriptionNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/secondMenu/ContactUsNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/secondMenu/ExtraNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/secondMenu/SettingNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/secondMenu/WorkBookEstimateNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/secondMenu/WorkBookNavigationModel.dart';

class BottomNavigationObject {
  static final homeNavigationItems = [
    SubscriptionNavigationModel(),
    IntroductionNavigationModel(),
    MoreNavigationModel(),
    HomePageNavigationModel(),
    WorkBookNavigationModel(),
  ];

  static final secondNavigationItems = [
    ExtraNavigationModel(),
    ContactUsNavigationModel(),
    SettingNavigationModel(),
    WorkBookEstimateNavigationModel(),
  ];

  static List<HomeNavigationModel> get homeMenu => homeNavigationItems;

  static List<HomeNavigationModel> get secondHomeMenu => secondNavigationItems;
}
