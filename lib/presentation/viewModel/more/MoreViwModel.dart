import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamak/presentation/uiModel/more/MoreItemModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class MoreViewModel extends BaseViewModel {
  late List<MoreItemModel> items;
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  MoreViewModel(super.initialState) {
    items = [
      MoreItemModel(iconData: Icons.logout, name: 'خروج', onClick: logoutClick),
      MoreItemModel(
          iconData: Icons.password_sharp,
          name: 'تغییر رمز',
          onClick: changePasswordClick),
      MoreItemModel(
          iconData: CupertinoIcons.person_3_fill,
          name: 'فرزندان من',
          onClick: addChildClick),
      MoreItemModel(
          iconData: CupertinoIcons.chart_pie,
          name: 'منابع',
          onClick: sourceClick),
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
}
