import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:mamak/config/apiRoute/BaseUrls.dart';
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
                  return ListView.separated(
                    padding: 16.dpe,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 30,
                              width: 30,
                              child: ImageLoader(
                                  url:
                                      '${BaseUrls.storagePath}/categories/${data[index].workShopId}.png')),
                          8.dph,
                          Text(data[index].workShopTitle ?? ''),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                bloc.gotoDetailView(data[index].workShopId);
                              },
                              icon: const Icon(Icons.remove_red_eye,
                                  color: Colors.grey),
                              label: const Text(
                                'کارنامه',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
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
