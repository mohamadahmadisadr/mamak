import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/home/CategoryDetailUseCase.dart';

class CategoryDetailViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  late String? id;

  CategoryDetailViewModel(super.initialState) {
    getExtra();
  }

  void getExtra() {
    id = _navigationServiceImpl.getArgs();
    if (id != null && id is String) {
      CategoryDetailUseCase().invoke(mainFlow, data: id);
    }
  }
}
