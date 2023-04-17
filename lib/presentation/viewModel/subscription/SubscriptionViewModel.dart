import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/subscribe/GetSubscribeUseCase.dart';

class SubscriptionViewModel extends BaseViewModel{
  SubscriptionViewModel(super.initialState){
    getSubscriptions();
  }


  void getSubscriptions(){
    GetSubscribeUseCase().invoke(mainFlow);
  }

}