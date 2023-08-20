import 'package:core/chart/model/ChartModel.dart';
import 'package:core/chart/radar_chart/radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/body/calendar/home_calendar.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/Home/HomeUI.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/newHome/new_categories_ui.dart';
import 'package:mamak/presentation/ui/newHome/segment_childs_ui.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';
import 'package:mamak/presentation/viewModel/home/new_home_viewModel.dart';

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
                if (bloc.selected != null)
                  HomeCalendarUi(selectedChild: bloc.selected!),
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
                              'کارنامه کلی',
                              style: context.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
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
                                  values: data.values, color: Colors.blue),
                            ],
                            labels: data.name,
                            maxValue: data.maxValue.toDouble(),
                            fillColor: Colors.blue,
                            maxLinesForLabels: 2,
                            maxWidth: MediaQuery.of(context).size.width - 80,
                            maxHeight: MediaQuery.of(context).size.width - 80,
                          ),
                        ],
                      );
                    },
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
