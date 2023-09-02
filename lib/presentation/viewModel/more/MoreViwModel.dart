import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/uiModel/more/MoreItemModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class MoreViewModel extends BaseViewModel {
  late List<MoreItemModel> items;
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  MoreViewModel(super.initialState) {
    defineItems();
  }

  void defineItems() {
    items = [
      MoreItemModel(
          iconData: CupertinoIcons.person_3_fill,
          name: 'my_chils'.tr,
          onClick: addChildClick),
      MoreItemModel(
          iconData: Icons.password_sharp,
          name: 'change_password'.tr,
          onClick: changePasswordClick),
      // MoreItemModel(
      //     iconData: Icons.language, name: 'languages'.tr, onClick: langsClick),
      MoreItemModel(
          iconData: CupertinoIcons.chart_pie,
          name: 'sources'.tr,
          onClick: sourceClick),
      MoreItemModel(
          iconData: Icons.logout, name: 'logout'.tr, onClick: logoutClick),
    ];
  }

  logoutClick() {
    session.clearSession();
    _navigationServiceImpl.replaceTo(AppRoute.login);
  }

  changePasswordClick() {
    _navigationServiceImpl.navigateTo(AppRoute.changePassword);
  }

  addChildClick() {
    _navigationServiceImpl.navigateTo(AppRoute.addChild);
  }

  sourceClick() {
    _navigationServiceImpl.navigateTo(AppRoute.sourceClick);
  }

  langsClick() {
    _navigationServiceImpl.navigateTo(AppRoute.languages)?.then((value) {
      defineItems();
      refresh();
    });
  }
}
