import 'package:core/Notification/MyNotification.dart';
import 'package:core/Notification/MyNotificationListener.dart';
import 'package:get/get.dart';
import 'package:mamak/core/network/errorHandler/ErrorModel.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';
import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/uiModel/workBook/ChartDataModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/child/GetChildsOfUserUseCase.dart';
import 'package:mamak/useCase/workBook/general_reportCard_useCase.dart';

class NewHomeViewModel extends BaseViewModel with MyNotificationListener {
  final MyNotification _notification = GetIt.I.get();
  AppState childState = AppState.idle;
  bool newUi = true;

  NewHomeViewModel(super.initialState) {
    _notification.subscribeListener(this);
    getChildOfUser();
  }

  AppState reportCardState = AppState.idle;

  ChildsItem? selected;

  onSelectNewChild(ChildsItem newChild) {
    selected = newChild;
    getGeneralReportCard();
    _notification.publish('CalendarViewModel', newChild.id!);
    refresh();
  }

  @override
  void onReceiveData(data) {
    if (data != null) {
      if (data is bool) {
        getChildOfUser();
      }
      if (data is ChildsItem) {
        onSelectNewChild(data);
      }
    }
  }

  @override
  String tag() => 'NewHomeViewModel';

  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }

  void getChildOfUser() {
    GetChildOfUserUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.getErrorModel?.state == ErrorState.Empty) {
        newUi = false;
      }
      if (appState.isSuccess) {
        if (appState.getData is List<ChildsItem>) {
          List<ChildsItem> child = appState.getData;
          if (child.isNotEmpty) {
            selected = child.first;
            onSelectNewChild(selected!);
            newUi = true;
            // _notification.publish('NewHomeViewModel', selected);
          }
        }
      }
      childState = appState;
      refresh();
    }));
  }

  void getGeneralReportCard() {
    if (selected != null) {
      GeneralReportCardUseCase().invoke(
        MyFlow(flow: (appState) {
          if (appState.isSuccess &&
              appState.getData is WorkBookDetailResponse) {
            reportCardState = AppState.success(
                (appState.getData as WorkBookDetailResponse)
                    .createUiModel(null));
          } else {
            reportCardState = appState;
          }
          refresh();
        }),
        data: selected!.id!,
      );
    }
  }

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
      lableData.add('$correct ${'from'.tr} $all');
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
        if (id.toString() ==
            (element.workShopDictionary?.categoryId?.toString() ?? '0')) {
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
