import 'package:flutter/animation.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/MoreNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/object/BottomNavigationObject.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class MainViewModel extends BaseViewModel {
  MainViewModel(super.initialState);

  AnimationController? animationController;
  var showSecondMenu = false;
  final homeMenu = BottomNavigationObject.homeMenu;
  final secondHomeMenu = BottomNavigationObject.secondHomeMenu;
  var _index = HomeNavigationEnum.Home.value;

  int get currentIndex => _index;

  Function(int) onIndexChange() {
    return (value) {
      if (homeMenu[value] is MoreNavigationModel) {
        onChangeSecondMenuState();
      } else {
        _index = value;
        updateScreen(time: value.toDouble());
      }
    };
  }

  void onChangeSecondMenuState() {
    showSecondMenu = !showSecondMenu;
    if (showSecondMenu) {
      animationController?.reverse(from: 0.5);
    } else {
      animationController?.forward(from: 0.0);
    }
    refreshScreen();
  }

  void refreshScreen() {
    updateScreen(time: DateTime.now().millisecond.toDouble());
  }
}
