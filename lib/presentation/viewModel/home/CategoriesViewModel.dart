import 'package:mamak/data/serializer/home/CategoryResponse.dart';
import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/uiModel/workBook/ChartDataModel.dart';
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
    if (id != null) {
      _navigationServiceImpl.navigateTo(AppRoute.categoryDetail, id);
    }
  }

  ChartDataModel getTotalChartData(
      List<GeneralReportCard>? cards, List<Category> categories) {
    List<String> names = categories.map((e) => e.title ?? '').toList();
    var maxValue = cards?.fold(
            0,
            (previousValue, element) =>
                previousValue > element.workShopReportCards.getMaxValue
                    ? previousValue
                    : element.workShopReportCards.getMaxValue) ??
        0;

    List<String> lableData = [];
    List<double> values = categories.map((e) {
      var id = e.id ?? 0;
      var currentValue = getTotalWorkBookThirdRate(id, cards);
      var correct = currentValue?.thirdRateAnswersCount ?? 0;
      var all = currentValue?.allQuestionsCount ?? 0;
      lableData.add('$correct از $all');
      var result = (all == 0 ? 0 : (maxValue * correct) / all).toDouble();
      return result;
    }).toList();

    return ChartDataModel(maxValue: maxValue, name: names, values: [values],lableData: lableData);
  }

  WorkShopReportCard? getTotalWorkBookThirdRate(
      int id, List<GeneralReportCard>? cards) {
    WorkShopReportCard? value;
    cards?.forEach((e) {
      e.workShopReportCards?.forEach((element) {
        if (id.toString() == element.workShopDictionary?.categoryId?.toString()) {

          value = element;
        }
      });
    });
    return value;
  }

  List<String> getUserWorkShops(List<GeneralReportCard>? cards) {
    List<String> workShops = [];
    cards?.forEach((e) {
      e.workShopReportCards?.forEach((element) {
        workShops.add(element.workShopDictionary?.name ?? '');
      });
    });
    return workShops;
  }
}
