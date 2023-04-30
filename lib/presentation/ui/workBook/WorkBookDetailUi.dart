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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  8.dpv,
                                  const MamakTitle(
                                      title: 'کارنامه', fontSize: 15),
                                  8.dpv,
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(32.0),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    child: SizedBox(
                                      height: 45,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: 8.dpe,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4.0, horizontal: 8.0),
                                            child: Text(data.header[index]),
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
                          const WorkBookItemUi(
                            name: 'کارنامه کلی',
                            data: [
                              WorkBookModel(
                                  name: 'ارزیابی ۱', color: Colors.green),
                              WorkBookModel(
                                  name: 'ارزیابی ۱', color: Colors.blue),
                            ],
                          ),
                          RadarChart(
                            spaceCount: 2,
                            textScaleFactor: .03,
                            strokeColor: Colors.grey,
                            values: const [
                              ChartModel(
                                  values: [1, 12, 17, 4, 18],
                                  color: Colors.red),
                              ChartModel(
                                  values: [4, 10, 5, 16, 2],
                                  color: Colors.blue),
                            ],
                            labels: const [
                              "ریاضی",
                              "هنر",
                              "شناخت جهان",
                              "سواد",
                              "تکنولوژی"
                            ],
                            maxValue: 20,
                            fillColor: Colors.blue,
                            maxLinesForLabels: 2,
                            maxWidth: MediaQuery.of(context).size.width - 50,
                            maxHeight: MediaQuery.of(context).size.width - 50,
                          ),
                          const WorkBookItemUi(name: 'کارنامه کلی', data: [
                            WorkBookModel(
                                name: 'ارزیابی ۱', color: Colors.green)
                          ]),
                          8.dpv,
                          RadarChart(
                            spaceCount: 2,
                            textScaleFactor: .03,
                            strokeColor: Colors.grey,
                            values: const [
                              ChartModel(
                                  values: [1, 12, 17, 4], color: Colors.red),
                            ],
                            labels: const [
                              "مقایسه",
                              "طبقه بندی",
                              "شمارش",
                              "گروه بندی"
                            ],
                            maxValue: 20,
                            fillColor: Colors.blue,
                            maxLinesForLabels: 2,
                            maxWidth: MediaQuery.of(context).size.width - 50,
                            maxHeight: MediaQuery.of(context).size.width - 50,
                          )
                        ],
                      ),
                    ),
                    8.dpv,
                    const WorkBookTableUi(),
                    8.dpv,
                    Container(
                      padding: 8.dpe,
                      margin: 16.dpe,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Text(
                        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ',
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium
                            ?.copyWith(color: Colors.red),
                      ),
                    ),
                    8.dpv,
                    ListView.builder(
                      itemBuilder: (context, index) => SuggestionItemUi(item: data.reviews.elementAt(index)),
                      shrinkWrap: true,
                      itemCount: data.reviews.length,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    8.dpv
                  ],
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

class WorkBookTableUi extends StatelessWidget {
  const WorkBookTableUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 16.dpe,
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        horizontalMargin: 0.0,
        border: TableBorder.all(
            color: Colors.grey.shade200, borderRadius: 8.bRadius),
        columnSpacing: 0.0,
        columns: List.generate(
          5,
          (index) => DataColumn(
            label: Expanded(
              child: Container(
                margin: 4.dpe,
                decoration:
                    BoxDecoration(color: Colors.grey, borderRadius: 16.bRadius),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Text('متن',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        rows: List.generate(
          4,
          (index) => DataRow(
            cells: List.generate(
              5,
              (index) => const DataCell(
                Center(
                    child: Text(
                  'داده',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.red),
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SuggestionItemUi extends StatelessWidget {
  const SuggestionItemUi({Key? key, required this.item}) : super(key: key);
  final WorkBookDetailReviews item;
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
          Text(
              item.question,
              style: context.textTheme.bodySmall),
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
                Text(
                    item.comment,
                    style: context.textTheme.bodyMedium),
              ],
            ),
          ),
          16.dpv,
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: MyTheme.purple),
              onPressed: () {},
              icon: const Icon(Icons.list_alt_sharp),
              label: const Text('دریافت راهکار'))
        ],
      ),
    );
  }
}
