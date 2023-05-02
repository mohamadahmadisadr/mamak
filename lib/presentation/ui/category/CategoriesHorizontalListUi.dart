import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/apiRoute/BaseUrls.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/data/serializer/home/CategoryResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/home/CategoriesViewModel.dart';

class CategoriesHorizontalListUi extends StatelessWidget {
  const CategoriesHorizontalListUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => CategoriesViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<List<Category>>(
          skeleton: Container(
            width: MediaQuery.of(context).size.width,
            height: 130,
            margin: 8.dpe,
            padding: 8.dpe,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: 8.bRadius,
            ),
          ),
          state: state,
          onSuccess: (data) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                onTap: (){
                  bloc.gotoDetail(data.elementAt(index).id?.toString());
                },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 90,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: ImageLoader(
                              url: BaseUrls.storagePath +
                                  '/categories/${data[index].id}.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            data[index].title ?? '',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: WidgetSize.smallTitle,
                            ),
                            textScaleFactor: 1.0,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
