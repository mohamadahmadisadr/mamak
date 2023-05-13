import 'package:core/chart/model/ChartModel.dart';
import 'package:core/chart/radar_chart/radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/home/CategoryResponse.dart';
import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/home/CategoriesViewModel.dart';
import 'package:mamak/presentation/viewModel/workBook/TotalWorkBookViewModel.dart';
import 'package:sprintf/sprintf.dart';

class TotalWorkBookChartUi extends StatelessWidget {
  const TotalWorkBookChartUi({
    Key? key,
    this.cards,
    required this.title, required this.categories,
  }) : super(key: key);
  final List<GeneralReportCard>? cards;
  final List<WorkShopCategory> categories;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => TotalWorkBookViewModel(AppState.idle),
      builder: (bloc, state) {
        var data = bloc.getTotalChartData(cards ?? [], categories);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              8.dpv,
              FutureBuilder(
                builder: (context, snapshot) {
                  List<String> workShops = bloc.getUserWorkShops(cards);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          4.dph,
                          Text(
                            sprintf(title, [
                              workShops.toSet().toList().length.toString(),
                              categories.length.toString()
                            ]),
                            style: context.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      4.dpv,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          4.dph,
                          Expanded(
                            child: Text(
                              sprintf('%s حوزه یادگیری عبارت است از %s', [
                                categories.length.toString(),
                                categories.map((e) => e.name).toList().join(',')
                              ]),
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      8.dpv,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          4.dph,
                          Expanded(
                            child: Text(
                              sprintf(
                                  'شما تا کنون در %s حوزه کودکتان را ارزیابی کرده اید‌: %s',
                                  [
                                    workShops.toSet().toList().length.toString(),
                                    workShops.toSet().toList().join(',')
                                  ]),
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              8.dpv,
              FittedBox(
              fit: BoxFit.fill,
                child: RadarChart(
                  spaceCount: data.maxValue ~/ 5,
                  textScaleFactor: .03,
                  strokeColor: Colors.grey,
                  values: [
                    ChartModel(values: data.values, color: Colors.blue),
                  ],
                  labels: data.name,
                  maxValue: data.maxValue.toDouble(),
                  fillColor: Colors.blue,
                  maxLinesForLabels: 2,
                  maxWidth: MediaQuery.of(context).size.width - 100,
                  maxHeight: MediaQuery.of(context).size.width - 100,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
