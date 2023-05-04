import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/data/serializer/home/CategoryResponse.dart';
import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookTableModel.dart';
import 'package:mamak/presentation/viewModel/home/CategoriesViewModel.dart';
import 'package:mamak/presentation/viewModel/workBook/WorkBookTableViewModel.dart';

class WorkBookTableUi extends StatelessWidget {
  const WorkBookTableUi({
    Key? key,
    required this.tableData, required this.categories,
  }) : super(key: key);
  final List<List<WorkBookTableModel>> tableData;
  final List<WorkShopCategory> categories;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => WorkBookTableViewModel(AppState.idle),
      builder: (bloc, state) {
        return Container(
          margin: 16.dpe,
          width: MediaQuery.of(context).size.width,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: DataTable(
              horizontalMargin: 0.0,
              border: TableBorder.all(
                  color: Colors.grey, borderRadius: 8.bRadius),
              columnSpacing: 0.0,
              columns: bloc.getColumnData(categories),
              rows: bloc.getCellsData(categories, tableData),
            ),
          ),
        );
      },
    );
  }
}
