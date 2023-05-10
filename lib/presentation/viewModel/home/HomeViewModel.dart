import 'package:core/Notification/MyNotification.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/home/HomeUseCase.dart';
import 'package:mamak/useCase/subscribe/GetRemainingDayUseCase.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(super.initialState) {
    getRemainingDay();
    // GetIt.I.get<MyNotification>().publish('MainViewModel', '5');
    // getHomeData();
  }


  void getRemainingDay(){
    GetRemainingDayUseCase().invoke(MyFlow(flow: (appState){
      if(appState.isSuccess){
        String count = appState.getData.toString();
        GetIt.I.get<MyNotification>().publish('MainViewModel', count);
      }
    }));
  }

  void getHomeData() {
    HomeUseCase().invoke(mainFlow);

  }

}
