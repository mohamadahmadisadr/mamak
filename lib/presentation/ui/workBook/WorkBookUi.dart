import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/workBook/WorkBooksResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/workBook/MothersWorkBookTabsUi.dart';
import 'package:mamak/presentation/viewModel/workBook/GetParticipatedWorkShopsOfChildUserViewModel.dart';

class WorkBookUi extends StatelessWidget {
  const WorkBookUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) =>
          GetParticipatedWorkShopsOfChildUserViewModel(AppState.idle),
      builder: (bloc, state) {
        return MamakScaffold(
          body: Column(
            children: [
              WorkBookTabBar(
                onSelectedItem: (childsItem) {
                  // if (childsItem.id != null) {
                  bloc.getWorkBooks(childsItem.id.toString());
                  // }
                },
              ),
              ConditionalUI<List<WorkBook>>(
                state: state,
                onSuccess: (data) {
                  var any = data.any((element) => element.workShopId == -1);
                  if (!any) {
                    data.add(WorkBook(workShopId: -1));
                  }
                  return Expanded(
                    child: ListView.separated(
                      padding: 16.dpe,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        if (data[index].workShopId == -1) {
                          return const SizedBox(height: 50);
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.memory(
                                  base64Decode(
                                      data[index].workShopFileContent ?? ''),
                                )),
                            8.dph,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${data[index].workShopTitle}'),
                                Text(
                                  '${data[index].packageAgeDomain}',
                                  style: context.textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  num? lastId;
                                  String? lastAgeDomain;
                                  for (var element in data) {
                                    double pAge = double.tryParse(element.toAgeDomain.toString()) ?? 0.0;
                                    double cAge = double.tryParse(data[index].toAgeDomain.toString()) ?? 0.0;
                                    if (element.workShopFileContent == data[index].workShopFileContent && pAge < cAge) {
                                      lastId = element.workShopId;
                                      lastAgeDomain = element.packageAgeDomain;
                                    }
                                  }
                                  bloc.gotoDetailView(data[index].workShopId,
                                      lastId: lastId, lastAgeDomain: lastAgeDomain);
                                },
                                icon: const Icon(Icons.remove_red_eye,
                                    color: Colors.grey),
                                label: Text(
                                  'workbook'.tr,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
