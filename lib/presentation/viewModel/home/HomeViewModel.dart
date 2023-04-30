import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/home/HomeUseCase.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(super.initialState) {
    // getHomeData();
  }

  void getHomeData() {
    HomeUseCase().invoke(mainFlow);
  }
}
