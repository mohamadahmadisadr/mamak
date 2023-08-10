import 'package:get/get.dart';
import 'package:mamak/presentation/ui/app/ShotViewrUi.dart';
import 'package:mamak/presentation/ui/category/CategoryDetailUI.dart';
import 'package:mamak/presentation/ui/child/AddChildUi.dart';
import 'package:mamak/presentation/ui/login/LoginUi.dart';
import 'package:mamak/presentation/ui/more/source_page.dart';
import 'package:mamak/presentation/ui/newHome/new_home_ui.dart';
import 'package:mamak/presentation/ui/package/PackageDetailUI.dart';
import 'package:mamak/presentation/ui/register/RegisterUi.dart';
import 'package:mamak/presentation/ui/root/MainPageUI.dart';
import 'package:mamak/presentation/ui/splash/SplashUi.dart';
import 'package:mamak/presentation/ui/user/ChangePasswordUi.dart';
import 'package:mamak/presentation/ui/user/ForgetPasswordUi.dart';
import 'package:mamak/presentation/ui/user/RecoveryPasswordUi.dart';
import 'package:mamak/presentation/ui/user/VerificationUi.dart';
import 'package:mamak/presentation/ui/workBook/WorkBookDetailUi.dart';
import 'package:mamak/presentation/ui/workShop/AssessmentsUi.dart';

import 'AppRoute.dart';

class AppRouteHelper {
  static List<GetPage> router = [
    GetPage(name: AppRoute.login, page: () => const LoginUi()),
    GetPage(name: AppRoute.register, page: () => const RegisterUi()),
    GetPage(name: AppRoute.home, page: () => const MainPageUI()),
    GetPage(name: AppRoute.root, page: () => const MainPageUI()),
    GetPage(name: AppRoute.splash, page: () => const SplashUi()),
    GetPage(name: AppRoute.splash, page: () => const SplashUi()),
    GetPage(name: AppRoute.verification, page: () => const VerificationUi()),
    GetPage(name: AppRoute.packageDetail, page: () => const PackageDetailUI()),
    GetPage(
        name: AppRoute.forgetPassword, page: () => const ForgetPasswordUi()),
    GetPage(
        name: AppRoute.changePassword, page: () => const ChangePasswordUi()),
    GetPage(
        name: AppRoute.recoveryPassword,
        page: () => const RecoveryPasswordUi()),
    GetPage(
        name: AppRoute.workBookDetail, page: () => const WorkBookDetailUi()),
    GetPage(name: AppRoute.assessments, page: () => const AssessmentsUi()),
    GetPage(name: AppRoute.addChild, page: () => const AddChildUi()),
    GetPage(
        name: AppRoute.categoryDetail, page: () => const CategoryDetailUI()),
    GetPage(name: AppRoute.shotViewer, page: () => const ShotViewerUi()),
    GetPage(name: AppRoute.newHome, page: () => const NewHomeUi()),
    GetPage(name: AppRoute.sourceClick, page: () => const SourceUi()),
  ];
}
