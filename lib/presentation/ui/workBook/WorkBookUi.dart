import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/child/WorkShopOfUserResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/child/ChildHorizontalListViewUi.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/ui/workBook/MothersWorkBookTabsUi.dart';
import 'package:mamak/presentation/viewModel/workBook/MyWorkShopsViewModel.dart';




class WorkBookUi extends StatelessWidget {
  const WorkBookUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MamakScaffold(
      body: Column(
        children: [
          WorkBookTabBar(
            onSelectedItem: (ChildsItem) {},
          ),
          CubitProvider(
            create: (context) => MyWorkShopsViewModel(AppState.idle),
            builder: (bloc, state) {
              return ConditionalUI<WorkShopOfUserResponse>(
                state: state,
                onSuccess: (data) {
                  List<ChildWorkShops> items =
                      data.inActiveUserChildWorkShops ?? [];
                  return ListView.separated(
                    padding: 16.dpe,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 30,
                              width: 30,
                              child: ImageLoader(
                                  url:
                                      'http://185.88.153.239:8000/images/WorkshopImage/638087784422316987riazi.png')),
                          8.dph,
                          Text(items[index].workShopTitle ?? ''),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                bloc.gotoDetailView(items[index].workShopId);
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
              );
            },
          )
        ],
      ),
    );
    return Container();
  }
}
