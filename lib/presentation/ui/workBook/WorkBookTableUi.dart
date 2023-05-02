import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/data/serializer/home/CategoryResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookTableModel.dart';
import 'package:mamak/presentation/viewModel/home/CategoriesViewModel.dart';

class WorkBookTableUi extends StatelessWidget {
  const WorkBookTableUi({
    Key? key,
    required this.tableData,
  }) : super(key: key);
  final List<List<WorkBookTableModel>> tableData;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => CategoriesViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<List<Category>>(
          skeleton: Container(
            decoration: BoxDecoration(
                borderRadius: 8.bRadius, color: Colors.grey.shade200),
          ),
          state: state,
          onSuccess: (cats) {
            return Container(
              margin: 16.dpe,
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                horizontalMargin: 0.0,
                border: TableBorder.all(
                    color: Colors.grey, borderRadius: 8.bRadius),
                columnSpacing: 0.0,
                columns: cats
                    .map((e) => DataColumn(
                          label: Expanded(
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200),
                              child: Center(
                                child: Padding(
                                  padding: 8.dpe,
                                  child: Text(e.title ?? '',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 1,
                                    style: TextStyle(fontSize: WidgetSize.smallTitle),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                rows: tableData
                    .map(
                      (workShops) => DataRow(
                        cells: cats.map((category) {
                          var item = workShops.firstWhereOrNull((element) => category.id?.toString() == element.id);
                          return DataCell(
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                    item?.value ?? 'انجام نشده',
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1,
                                    style: TextStyle(color: item == null ? Colors.red : Colors.black,fontSize: WidgetSize.smallTitle),
                                  )),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        );
      },
    );
  }
}
