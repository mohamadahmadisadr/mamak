import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/workBook/MotherWorkBookViewModel.dart';

class MothersWorkBookUi extends StatefulWidget {
  const MothersWorkBookUi({Key? key}) : super(key: key);

  @override
  State<MothersWorkBookUi> createState() => _MothersWorkBookUiState();
}

class _MothersWorkBookUiState extends State<MothersWorkBookUi>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => MotherWorkBookViewModel(AppState.idle),
      builder: (bloc, state) {
        return MamakScaffold(
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0),
                  ),
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: 16.dpe,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const MamakTitle(title: 'کارنامه'),
                      16.dpv,
                      Container(
                        padding: 4.dpe,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.0),
                          color: Colors.grey.withOpacity(.3),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0)),
                          tabs: const [
                            Tab(child: Text('فرزند اول')),
                            Tab(
                              child: Text('ف رزند دوم'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.separated(
                padding: 8.dpe,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                          height: 50,
                          width: 50,
                          child: ImageLoader(url: 'url')),
                      8.dph,
                      const Text('ریاضی'),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: TextButton.icon(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: Colors.grey),
                          ),
                          onPressed: () {},
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
              )
            ],
          ),
        );
      },
    );
  }
}
