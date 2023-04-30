import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/home/GetAllCategoriesUseCase.dart';

class CategoriesViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  CategoriesViewModel(super.initialState) {
    getCategories();
  }

  void getCategories() {
    GetAllCategoriesUseCase().invoke(mainFlow);
  }

  void gotoDetail(String? id) {
    if (id != null){
      _navigationServiceImpl.navigateTo(AppRoute.categoryDetail,id);
    }
  }
}
