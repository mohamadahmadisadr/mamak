import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/uiModel/workBook/ChartDataModel.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookTableModel.dart';

class WorkBookDetailUiModel {
  final List<String> headerTitle;
  final List<String> header;
  final List<WorkBookDetailReviews> reviews;
  final List<WorkShopCategory> categories;
  final String workShop,
      workShopWorkBookTitle,
      workShopWorkBookDescription,
      counter,
      totalWorkBookTitle;
  final ChartDataModel workShpChartModel;
  final List<GeneralReportCard> cards;
  final List<List<WorkBookTableModel>> tableData;

  const WorkBookDetailUiModel({
    required this.headerTitle,
    required this.header,
    required this.reviews,
    required this.categories,
    required this.workShop,
    required this.workShopWorkBookTitle,
    required this.workShopWorkBookDescription,
    required this.counter,
    required this.workShpChartModel,
    required this.totalWorkBookTitle,
    required this.cards,
    required this.tableData,
  });
}

class WorkBookDetailReviews {
  final String question, comment;

  const WorkBookDetailReviews({required this.question, required this.comment});
}
