import 'package:core/chart/model/ChartModel.dart';
import 'package:core/chart/radar_chart/radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/child/WorkShopOfUserResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/Home/HomeUI.dart';
import 'package:mamak/presentation/ui/bottomSheets/weekly_plan_sheet.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/newHome/new_categories_ui.dart';
import 'package:mamak/presentation/ui/newHome/segment_childs_ui.dart';
import 'package:mamak/presentation/ui/workShop/MyWorkShops.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';
import 'package:mamak/presentation/viewModel/home/new_home_viewModel.dart';
import 'package:mamak/presentation/viewModel/workBook/MyWorkShopsViewModel.dart';

class NewHomeUi extends StatefulWidget {
  const NewHomeUi({Key? key}) : super(key: key);

  @override
  State<NewHomeUi> createState() => _NewHomeUiState();
}

class _NewHomeUiState extends State<NewHomeUi> {
  @override
  Widget build(BuildContext context) {
    return MamakScaffold(
      body: CubitProvider(
        create: (context) => NewHomeViewModel(AppState.idle),
        builder: (bloc, state) {
          if (bloc.newUi == false) {
            return const HomeUI();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentChildUi(
                  onSelectChild: bloc.onSelectNewChild,
                  state: bloc.childState,
                  selectedChild: bloc.selected,
                ),
                // HomeCalendarUi(selectedChild: bloc.selected!),
                CubitProvider(
                  create: (context) => MyWorkShopsViewModel(AppState.idle,
                      selectedChild: bloc.selected),
                  builder: (bloc, state) {
                    return ConditionalUI<WorkShopOfUserResponse>(
                      skeleton: const MyLoader(),
                      state: state,
                      onSuccess: (data) {
                        List<ChildWorkShops> items =
                            (data.activeUserChildWorkShops ?? []) +
                                (data.inActiveUserChildWorkShops ?? []);
                        return ListView.builder(
                          padding: 8.dpeh,
                          itemBuilder: (context, index) => MyWorkShopItemUi(
                            item: items[index],
                            childsItem: bloc.selectedChild!,
                          ),
                          itemCount: items.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        );
                      },
                    );
                  },
                ),
                if (bloc.selected != null)
                  ConditionalUI<WorkBookDetailUiModel>(
                    showError: false,
                    state: bloc.reportCardState,
                    onSuccess: (reportCard) {
                      var data = bloc.getTotalChartData(
                          reportCard.cards, reportCard.categories);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: 8.dpeh,
                            child: Text(
                              'total_workBook'.tr,
                              style: context.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          RadarChart(
                            spaceCount: data.maxValue < 5
                                ? data.maxValue
                                : data.maxValue ~/ 5,
                            textScaleFactor: .03,
                            strokeColor: Colors.grey,
                            values: [
                              ChartModel(
                                  values: data.values.first, color: Colors.blue),
                            ],
                            labels: data.name,
                            maxValue: data.maxValue.toDouble(),
                            fillColor: Colors.blue,
                            maxLinesForLabels: 1,
                            maxWidth: MediaQuery.of(context).size.width - 100,
                            maxHeight: MediaQuery.of(context).size.width - 80,
                          ),
                        ],
                      );
                    },
                  ),
                8.dpv,
                if (bloc.selected != null)
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.bottomSheet(
                            isScrollControlled: true,
                            WeeklyPlanSheet(childsItem: bloc.selected!),
                          );
                        },
                        child: Text(
                          'weekly'.tr,
                          style: const TextStyle(
                              color: Colors.red, fontFamily: 'dana'),
                        ),
                      ),
                    ],
                  ),
                8.dpv,
                const NewCategoriesUi(),
                54.dpv
              ],
            ),
          );
        },
      ),
    );
  }
}
