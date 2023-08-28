import 'dart:convert';

import 'package:core/color/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/home/CategoryResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
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
            return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
          skeleton: const MyLoader(),
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
      height: 100,
      width: MediaQuery.of(context).size.width,
        padding: 8.dpe,
        margin: 4.dpe,
        decoration: BoxDecoration(
          color: category.colorNumber?.toColor(),
          borderRadius: 16.bRadius,
        ),
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Expanded(child: Text(category.title ?? '',style: context.textTheme.titleSmall?.copyWith(fontSize: 17,fontWeight: FontWeight.bold),textAlign: TextAlign.start)),
            SizedBox(
            height: 80,
            width: 80,
                child: Image.memory(
                  base64Decode(
                      category.parentCategoryFiles?.first.file?.content ??
                          ''),
                  fit: BoxFit.fill,
                )),
            const SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }
}
