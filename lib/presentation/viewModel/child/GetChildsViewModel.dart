import 'package:core/Notification/MyNotificationListener.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/child/GetChildsOfUserUseCase.dart';
import 'package:core/Notification/MyNotification.dart';


class GetChildViewModel extends BaseViewModel with MyNotificationListener{
  AppState uiState = AppState.idle;
  final MyNotification _notification = GetIt.I.get();
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  ChildsItem? selectedChild;
  GetChildViewModel(super.initialState) {
    _notification.subscribeListener(this);
    getChildOfUser();
  }

  void getChildOfUser() {
    GetChildOfUserUseCase().invoke(MyFlow(flow: (appState){
      if(appState.isSuccess){
        if(appState.getData is List<ChildsItem>){
          List<ChildsItem> child = appState.getData;
          if(child.isNotEmpty){
            selectedChild = child.first;
            _notification.publish('MyWorkShopsViewModel', selectedChild);
            _notification.publish('GetParticipatedWorkShopsOfChildUserViewModel', selectedChild);
            _notification.publish('EditChildDataViewModel', selectedChild);
            _notification.publish('NewHomeViewModel', selectedChild);
          }

        }
      }
      uiState = appState;
      refresh();
    }));
  }

  void onChangeSelectedChild(ChildsItem childsItem){
    selectedChild = childsItem;
    _notification.publish('MyWorkShopsViewModel', selectedChild);
    _notification.publish('GetParticipatedWorkShopsOfChildUserViewModel', selectedChild);
    _notification.publish('EditChildDataViewModel', selectedChild);
    refresh();
  }


  void refresh(){
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }



  void goToAddChild() {
    _navigationServiceImpl.navigateTo(AppRoute.addChild);
  }


  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }

  @override
  void onReceiveData(data) {
    if(data != null){
      getChildOfUser();
    }
  }

  @override
  String tag() {
    return 'GetChildViewModel';
  }
}
