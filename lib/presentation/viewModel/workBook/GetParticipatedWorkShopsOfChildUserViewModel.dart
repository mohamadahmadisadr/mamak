import 'package:core/Notification/MyNotification.dart';
import 'package:core/Notification/MyNotificationListener.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/workBook/GetParticipatedWorkShopsOfChildUserUseCase.dart';

class GetParticipatedWorkShopsOfChildUserViewModel extends BaseViewModel implements MyNotificationListener {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  final MyNotification _notification = GetIt.I.get();
  WorkBookParamsModel model = WorkBookParamsModel();
  late ChildsItem selectedChild;

  GetParticipatedWorkShopsOfChildUserViewModel(super.initialState) {
    _notification.subscribeListener(this);
    getExtra();
  }

  void getWorkBooks(String userChildId) {
    GetParticipatedWorkShopsOfChildUserUseCase().invoke(
      mainFlow,
      data: userChildId,
    );
  }

  void getExtra() {
    String? userChildId = _navigationServiceImpl.getArgs();
    if (userChildId != null) {
      getWorkBooks(userChildId);
    }
  }

  gotoDetailView(num? id) {
    if (id != null) {
      model.workShopId = id.toString();
      _navigationServiceImpl.navigateTo(AppRoute.workBookDetail, model);
    }
  }

  @override
  void onReceiveData(data) {
    if(data != null){
      if(data is ChildsItem){
        selectedChild = data;
        model.userChildId = (data).id.toString();
        getWorkBooks((data).id.toString());
      }
    }
  }

  @override
  String tag() {
    return 'GetParticipatedWorkShopsOfChildUserViewModel';
  }

  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }
}
