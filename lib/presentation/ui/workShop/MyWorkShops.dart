import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/apiRoute/BaseUrls.dart';
import 'package:mamak/config/uiCommon/MyTheme.dart';
import 'package:mamak/config/uiCommon/WidgetSize.dart';
import 'package:mamak/core/locale/locale_extension.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';
import 'package:mamak/data/serializer/child/WorkShopOfUserResponse.dart';
import 'package:mamak/presentation/ui/child/ChildHorizontalListViewUi.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/uiModel/assessmeny/AssessmentParamsModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/presentation/viewModel/workBook/MyWorkShopsViewModel.dart';

import '../dialog/VideoPlayerDialog.dart';

class MyWorkShops extends StatelessWidget {
  const MyWorkShops({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MamakScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.0),
                  bottomRight: Radius.circular(32.0),
                ),
                color: MyTheme.purple,
              ),
              child: Padding(
                padding: 16.dpe,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MamakTitle(title: 'user_workshops'.tr),
                    16.dpv,
                    ChildHorizontalListViewUi(
                      onSelectedItem: (child) {},
                      isAssessment: true,
                    ),
                  ],
                ),
              ),
            ),
            8.dpv,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('choose_assessment_type'.tr,
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
            ),
            8.dpv,
            CubitProvider(
              create: (context) => MyWorkShopsViewModel(AppState.idle),
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
                        childsItem: bloc.selectedChild,
                      ),
                      itemCount: items.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyWorkShopItemUi extends StatelessWidget {
  const MyWorkShopItemUi({
    Key? key,
    required this.item,
    required this.childsItem,
  }) : super(key: key);
  final ChildWorkShops item;
  final ChildsItem childsItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Opacity(
            opacity: item.isActive == true ? 1.0 : .5,
            child: Container(
              padding: 8.dpe,
              margin: 8.dpe,
              decoration: BoxDecoration(
                  borderRadius: 8.bRadius,
                  color: item.isActive == true
                      ? MyTheme.purple
                      : Colors.grey.shade100),
              child: InkWell(
                borderRadius: 8.bRadius,
                onTap: () {
                  AssessmentParamsModel assessmentParam = AssessmentParamsModel(
                    name: childsItem.childFirstName ?? '',
                    id: item.id?.toString() ??
                        ''
                            '',
                    childId: childsItem.id?.toString() ?? '',
                    workShopId: item.workShopId?.toString() ?? '',
                    course: item.workShopTitle ?? '',
                  );
                  GetIt.I
                      .get<NavigationServiceImpl>()
                      .navigateTo(AppRoute.assessments, assessmentParam);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                          item.workShopTitle ?? '',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textScaleFactor: 1.0,
                          style:
                              const TextStyle(fontSize: WidgetSize.smallTitle)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          item.packageAgeDomain ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textScaleFactor: 1.0,
                          style: const TextStyle(
                            fontSize: WidgetSize.smallTitle,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        textAlign: Get.locale.isPersian ? TextAlign.left : TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textScaleFactor: 1.0,
                        "${item.questionCount} ${'questions'.tr}",
                        style: const TextStyle(fontSize: WidgetSize.smallTitle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              var link =
                  '${BaseUrls.storagePath}/Categories/${item.parentCategoryId}.mp4';
              Get.dialog(VideoPlayerDialog(link: link));
            },
            icon: const Icon(Icons.play_circle_outline_outlined))
      ],
    );
  }
}
