import 'package:core/chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/MyTheme.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/workBook/TotalWorkBookChartUi.dart';
import 'package:mamak/presentation/ui/workBook/WorkBookTableUi.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';
import 'package:mamak/presentation/viewModel/workBook/ReportCardViewModel.dart';

class WorkBookDetailUi extends StatelessWidget {
  const WorkBookDetailUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ReportCardViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<WorkBookDetailUiModel>(
          state: state,
          onSuccess: (data) {
            return MamakScaffold(
              body: SingleChildScrollView(
                child: RepaintBoundary(
                  key: bloc.key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: 8.dpe,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: 32.radius,
                              bottomLeft: 32.radius,
                            ),
                            color: Colors.grey.shade100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0),
                                ),
                                color: Colors.grey.shade100,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    8.dpv,
                                    const MamakTitle(
                                        title: 'کارنامه', fontSize: 15),
                                    8.dpv,
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      child: SizedBox(
                                        height: 45,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          padding: 8.dpe,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) /
                                                  (data.header.length + 1),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0,
                                                        horizontal: 8.0),
                                                child: Text(
                                                  data.headerTitle[index],
                                                  textScaleFactor: 1,
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const VerticalDivider(
                                                width: 1);
                                          },
                                          itemCount: data.header.length,
                                        ),
                                      ),
                                    ),
                                    4.dpv,
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      child: SizedBox(
                                        height: 45,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          padding: 8.dpe,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) /
                                                  (data.header.length + 1),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0,
                                                        horizontal: 8.0),
                                                child: Text(
                                                  data.header[index],
                                                  textScaleFactor: 1,
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const VerticalDivider(
                                                width: 1);
                                          },
                                          itemCount: data.header.length,
                                        ),
                                      ),
                                    ),
                                    4.dpv,
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    data.workShop,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  4.dph,
                                  Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text('(${data.counter})')),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Expanded(
                                        child: Text(
                                          data.workShopWorkBookTitle,
                                          style: context.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  4.dpv,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          data.workShopWorkBookDescription,
                                          style: context.textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            8.dpv,
                            RadarChart(
                              spaceCount: 2,
                              textScaleFactor: .03,
                              strokeColor: Colors.grey,
                              values: [
                                ChartModel(
                                    values: data.workShpChartModel.values,
                                    color: Colors.blue),
                              ],
                              labels: data.workShpChartModel.name,
                              maxValue:
                                  data.workShpChartModel.maxValue.toDouble(),
                              fillColor: Colors.blue,
                              maxLinesForLabels: 2,
                              maxWidth: MediaQuery.of(context).size.width - 50,
                              maxHeight: MediaQuery.of(context).size.width - 50,
                            ),
                            8.dpv,
                            // const WorkBookItemUi(
                            //   name: 'کارنامه کلی',
                            //   data: [
                            //     WorkBookModel(
                            //         name: 'ارزیابی ۱', color: Colors.green),
                            //     WorkBookModel(
                            //         name: 'ارزیابی ۱', color: Colors.blue),
                            //   ],
                            // ),
                            TotalWorkBookChartUi(
                              cards: data.cards,
                              categories: data.categories,
                              title: data.totalWorkBookTitle,
                            ),
                          ],
                        ),
                      ),
                      8.dpv,
                      Padding(
                        padding: 16.dpeh,
                        child: const Text(
                          'خلاصه عملكرد در ارزيابي حوزه ها',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      WorkBookTableUi(
                          tableData: data.tableData,
                          categories: data.categories),
                      Container(
                        padding: 8.dpe,
                        child: Text(
                          'راهکارهای توانمندی هایی که کودکتان نیاز به رشد دارد را دانلود کنید، دو هفته در منزل با او بازی کنید و مجددا ارزیابی را انجام دهید',
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleMedium
                              ?.copyWith(color: Colors.red),
                        ),
                      ),
                      8.dpv,
                      ListView.builder(
                        itemBuilder: (context, index) => SuggestionItemUi(
                          index: index + 1,
                          item: data.reviews.elementAt(index),
                          onItemClick: () {
                            bloc.onSolutionItemClick(
                                data.reviews.elementAt(index));
                          },
                        ),
                        shrinkWrap: true,
                        itemCount: data.reviews.length,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      8.dpv,
                      Padding(
                        padding: 16.dpe,
                        child: ElevatedButton(
                            onPressed: bloc.getWorkBookShot,
                            child: const Text('دانلود کارنامه')),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class WorkBookItemUi extends StatelessWidget {
  const WorkBookItemUi({Key? key, required this.name, required this.data})
      : super(key: key);
  final String name;
  final List<WorkBookModel> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 8.dpe,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: data.map((e) => WorkBookItemContentUi(model: e)).toList(),
          )
        ],
      ),
    );
  }
}

class WorkBookItemContentUi extends StatelessWidget {
  final WorkBookModel model;

  const WorkBookItemContentUi({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 4.dpev,
      child: Column(
        children: [
          Row(
            children: [
              Text(model.name),
              4.dph,
              Container(
                margin: 4.dpeh,
                height: 20,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: model.color,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class WorkBookModel {
  final String name;
  final Color color;

  const WorkBookModel({required this.name, required this.color});
}

class SuggestionItemUi extends StatelessWidget {
  const SuggestionItemUi(
      {Key? key,
      required this.item,
      required this.index,
      required this.onItemClick})
      : super(key: key);
  final WorkBookDetailReviews item;
  final int index;
  final Function() onItemClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.dpe,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade100, width: 1),
          borderRadius: BorderRadius.only(
            topLeft: 16.radius,
            bottomLeft: 16.radius,
            bottomRight: 16.radius,
          ),
          color: Colors.grey.shade50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'توانمندی',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          8.dpv,
          Text('$index.${item.question}', style: context.textTheme.bodySmall),
          8.dpv,
          Container(
            padding: 16.dpe,
            margin: 8.dpe,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200, width: 1),
                borderRadius: BorderRadius.only(
                  topLeft: 16.radius,
                  bottomLeft: 16.radius,
                  bottomRight: 16.radius,
                ),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'نظر مادر',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                8.dpv,
                Text(item.comment, style: context.textTheme.bodyMedium),
              ],
            ),
          ),
          16.dpv,
          if (item.answerRate != '' &&
              item.answerRate == '3' &&
              item.fileDataId != null)
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: MyTheme.purple, backgroundColor: MyTheme.purple),
                onPressed: onItemClick,
                icon: const Icon(Icons.list_alt_sharp),
                label: const Text(
                  'دریافت راهکار',
                ))
        ],
      ),
    );
  }
}
