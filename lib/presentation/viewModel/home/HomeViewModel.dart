import 'package:core/Notification/MyNotification.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';
import 'package:mamak/presentation/ui/dialog/AddChildDialog.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/BaseUseCase.dart';
import 'package:mamak/useCase/child/GetChildsOfUserUseCase.dart';
import 'package:mamak/useCase/home/HomeUseCase.dart';
import 'package:mamak/useCase/subscribe/GetRemainingDayUseCase.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(super.initialState) {
    // getRemainingDay();
    // getChildOfUser();
    // GetIt.I.get<MyNotification>().publish('MainViewModel', '5');
    // getHomeData();
  }




  void getHomeData() {
    HomeUseCase().invoke(mainFlow);

  }

}
