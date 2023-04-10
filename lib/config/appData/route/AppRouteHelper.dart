import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/ui/login/LoginUi.dart';
import 'package:mamak/presentation/ui/package/PackageDetailUI.dart';
import 'package:mamak/presentation/ui/register/RegisterUi.dart';
import 'package:mamak/presentation/ui/root/MainPageUI.dart';

import 'AppRoute.dart';

class AppRouteHelper {

  static List<GetPage> router = [
    GetPage(name: AppRoute.login, page: () => const LoginUi()),
    GetPage(name: AppRoute.register, page: () => const RegisterUi()),
    GetPage(name: AppRoute.home, page: () => const MainPageUI()),
    GetPage(name: AppRoute.root, page: () => const MainPageUI()),
    GetPage(name: AppRoute.packageDetail, page: () => const PackageDetailUI()),
  ];
}
