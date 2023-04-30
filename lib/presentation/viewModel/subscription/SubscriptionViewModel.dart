import 'package:mamak/data/serializer/subscribe/AllSubscriptionResponse.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/subscribe/CurrentPackageUseCase.dart';
import 'package:mamak/useCase/subscribe/GetAllSubscriptionsUseCase.dart';

class SubscriptionViewModel extends BaseViewModel {
  AppState uiState = AppState.idle;
  AppState mySubscriptionState = AppState.idle;
  AllSubscriptionItem? selectedItem;

  SubscriptionViewModel(super.initialState) {
    getSubscriptions();
    getCurrentSubscription();
  }

  void getSubscriptions() {
    GetAllSubscriptionsUseCase().invoke(MyFlow(flow: (appState) {
      // if (appState.isSuccess) {
      //   if (appState.getData is List<AllSubscriptionItem>) {
      //     List<AllSubscriptionItem> child = appState.getData;
      //     if (child.isNotEmpty) {
      //       selectedItem = child.first;
      //     }
      //   }
      // }
      uiState = appState;
      refresh();
    }));
  }

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  onChangeSelectedItem(AllSubscriptionItem? newSelected) {
    if (newSelected != null) {
      selectedItem = newSelected;
      refresh();
    }
  }

  void getCurrentSubscription() {
    CurrentPackageUseCase().invoke(MyFlow(flow: (appState) {
      mySubscriptionState = appState;
      refresh();
    }));
  }
}
