import 'package:core/Notification/MyNotification.dart';
import 'package:core/Notification/MyNotificationListener.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:mamak/core/network/errorHandler/ErrorModel.dart';
import 'package:mamak/presentation/ui/dialog/AddChildDialog.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/MoreNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/SubscriptionNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/object/BottomNavigationObject.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/child/GetChildsOfUserUseCase.dart';
import 'package:mamak/useCase/subscribe/GetRemainingDayUseCase.dart';

class MainViewModel extends BaseViewModel implements MyNotificationListener {
  AnimationController? animationController;
  var showSecondMenu = false;
  final homeMenu = BottomNavigationObject.homeMenu;
  final secondHomeMenu = BottomNavigationObject.secondHomeMenu;
  var _index = HomeNavigationEnum.Home.value;
  final MyNotification _notification = GetIt.I.get();

  int get currentValue => _index;

  List<HomeNavigationModel> get totalMenu => homeMenu + secondHomeMenu;

  MainViewModel(super.initialState) {
    _notification.subscribeListener(this);
    getRemainingDay();
    getChildOfUser();
  }

  Function(int) onIndexChange() {
    return (value) {
      var item = totalMenu
          .firstWhereOrNull((element) => element.value().value == value);
      if (item != null) {
        if (item is MoreNavigationModel) {
          onChangeSecondMenuState();
        } else {
          // if (item is SubscriptionNavigationModel) {
          //   if ((item).getBadge != '') {
          //     messageService.showSnackBar(
          //         '${item.getBadge} روز از اشتراک شما باقی مانده است');
          //     //can show message here
          //     return;
          //   }
          // }
          _index = item.value().value;
          updateScreen(time: value.toDouble());
        }
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

  void updateRemainingDay(String value) {
    var index = homeMenu.indexWhere((element) =>
        element.value().index == HomeNavigationEnum.Subscription.value);
    if (index != -1) {
      (homeMenu[index] as SubscriptionNavigationModel).changeBadge(value);
      refreshScreen();
    }
  }

  void refreshScreen() {
    updateScreen(time: DateTime.now().millisecond.toDouble());
  }

  @override
  void onReceiveData(data) {
    if (data != null) {
      if (data is int) {
        //change index of bottom navigation
        int index = data;
        onIndexChange().call(index);
      } else if (data is String) {
        //Change subscription badge
        updateRemainingDay(data);
      }
    }
  }

  void getChildOfUser() {
    GetChildOfUserUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isFailed) {
        if (appState.getErrorModel?.state == ErrorState.Empty) {
          Get.dialog(const AddChildDialog());
        }
      }
    }));
  }

  void getRemainingDay() {
    GetRemainingDayUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess) {
        String count = appState.getData.toString();
        GetIt.I.get<MyNotification>().publish('MainViewModel', count);
      }
    }));
  }

  @override
  String tag() {
    return 'MainViewModel';
  }

  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }
}
