import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/subscribe/GetSubscribeUseCase.dart';

class SignUpViewModel extends BaseViewModel {


  int selectedItem = 0;

  SignUpViewModel(super.initialState) {
    fetchSubscribes();
  }

  AppState subscribesState = AppState.idle;

  void fetchSubscribes() {
    GetSubscribeUseCase().invoke(
      MyFlow(
        flow: (subscribesState) {
          this.subscribesState = subscribesState;
        },
      ),
    );
  }


  Function(int?) onItemChanged() {
    return (value) {
      if (value != null) {
        selectedItem = value;
      }
    };
  }
}
