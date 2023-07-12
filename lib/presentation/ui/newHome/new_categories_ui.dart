import 'dart:convert';

import 'package:core/color/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/home/CategoryResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/home/CategoriesViewModel.dart';

class NewCategoriesUi extends StatelessWidget {
  const NewCategoriesUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CubitProvider(
      create: (context) => CategoriesViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<List<Category>>(
          state: state,
          onSuccess: (categories) {
            return StaggeredGrid.count(
              crossAxisCount: 6,
              mainAxisSpacing: 2,
              crossAxisSpacing: 3,
              children: categories.map((category) => StaggeredGridTile.count(
                crossAxisCellCount: categories.indexOf(category) > 2 ? 3 : 2,
                mainAxisCellCount: 2,
                child: NewCategoryItemUi(
                  category: category,
                  onClick: (data) {
                    bloc.gotoDetail(data);
                  },
                ),
              )).toList()
              ,);
          },
          skeleton: SizedBox(),
        );
      },
    );
  }
}

class NewCategoryItemUi extends StatelessWidget {
  const NewCategoryItemUi(
      {Key? key, required this.category, required this.onClick})
      : super(key: key);
  final Category category;
  final Function(String) onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call(category.id?.toString() ?? '0');
      },
      child: Container(
      width: 120,
        padding: 8.dpe,
        margin: 4.dpe,
        decoration: BoxDecoration(
          color: category.colorNumber?.toColor(),
          borderRadius: 16.bRadius,
        ),
        child: Column(
          children: [
            Spacer(),
            Text(category.title ?? '',style: context.textTheme.titleSmall?.copyWith(fontSize: 15),textAlign: TextAlign.center,),
            Spacer(),
            FittedBox(
            fit: BoxFit.fill,
              child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Image.memory(
                    base64Decode(
                        category.parentCategoryFiles?.first.file?.content ??
                            ''),
                    fit: BoxFit.fill,
                  )),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
