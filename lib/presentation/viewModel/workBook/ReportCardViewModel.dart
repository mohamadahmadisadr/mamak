import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/workBook/ReportCardUseCase.dart';

class ReportCardViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  ReportCardViewModel(super.initialState) {
    getExtra();
  }

  void getExtra() {
    var model = _navigationServiceImpl.getArgs();
    if (model != null && model is WorkBookParamsModel) {
      getReportCard(model);
    }
  }

  void getReportCard(WorkBookParamsModel model) {
    ReportCardUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is WorkBookDetailResponse) {
        mainFlow.emit(AppState.success(
            (appState.getData as WorkBookDetailResponse).createUiModel()));
      } else {
        mainFlow.emit(appState);
      }
    }), data: model);
  }
}
