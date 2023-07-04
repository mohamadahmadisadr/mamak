import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/uiModel/workBook/ChartDataModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class TotalWorkBookViewModel extends BaseViewModel {
  TotalWorkBookViewModel(super.initialState);

  ChartDataModel getTotalChartData(
      List<GeneralReportCard>? cards, List<WorkShopCategory> categories) {
    List<String> names = categories.map((e) => e.name).toList();
    var maxValue = cards?.fold(
            0,
            (previousValue, element) =>
                previousValue > element.workShopReportCards.getMaxValue
                    ? previousValue
                    : element.workShopReportCards.getMaxValue) ??
        0;

    List<String> lableData = [];
    List<double> values = categories.map((e) {
      var id = e.id;

      var correct = 0;

      var all = 0;

      var currentValues = getTotalWorkBookThirdRate(id, cards);
      currentValues?.map((e) {
        correct += e.thirdRateAnswersCount ?? 0;
        all += e.allQuestionsCount ?? 0;
      }).toList();
      lableData.add('$correct از $all');
      var result = (all == 0 ? 0 : (maxValue * correct) / all).toDouble();
      return result;
    }).toList();

    return ChartDataModel(
        maxValue: maxValue, name: names, values: values, lableData: lableData);
  }

  List<WorkShopReportCard>? getTotalWorkBookThirdRate(
      String id, List<GeneralReportCard>? cards) {
    List<WorkShopReportCard> values = [];
    cards?.forEach((e) {
      e.workShopReportCards?.forEach((element) {
        if (id.toString() == element.workShopDictionary?.categoryId?.toString()) {
          values.add(element);
        }
      });
    });
    return values;
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
