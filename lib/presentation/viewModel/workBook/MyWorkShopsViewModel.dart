import 'dart:convert';

import 'package:core/Notification/MyNotification.dart';
import 'package:core/Notification/MyNotificationListener.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/child/GetWorkShopsOfChildUserUseCase.dart';

class MyWorkShopsViewModel extends BaseViewModel
    implements MyNotificationListener {
  final MyNotification _notification = GetIt.I.get();
  WorkBookParamsModel model = WorkBookParamsModel();

  late ChildsItem selectedChild;

  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  MyWorkShopsViewModel(super.initialState) {
    _notification.subscribeListener(this);
  }

  getWorkShopsByChildId(String childId) {
    print(childId);
    if(!state.isLoading) {
      GetWorkShopsOfChildUserUseCase().invoke(mainFlow, data: childId.toString());
    }
  }

  @override
  void onReceiveData(data) {
    print(jsonEncode(data));
    if (data != null) {
      if(data is ChildsItem){
        selectedChild = data;
        model.userChildId = (data).id.toString();
        getWorkShopsByChildId((data).id.toString());
      }
      if(data is bool && data == true){
        getWorkShopsByChildId(model.userChildId);
      }

    }
  }

  @override
  String tag() => 'MyWorkShopsViewModel';

  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }

  gotoDetailView(num? id) {
    if (id != null) {
      model.workShopId = id.toString();
      _navigationServiceImpl.navigateTo(AppRoute.workBookDetail, model);
    }
  }
}
