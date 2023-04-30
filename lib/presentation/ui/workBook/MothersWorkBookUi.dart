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
  var index = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
      });
    });
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
                          color: Colors.grey.withOpacity(.4),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius: getBorderByIndex(index)),
                          tabs: const [
                            WorkBookTabUi(
                              name: 'فرزند اول',
                            ),
                            WorkBookTabUi(
                              name: 'فرزند دوم',
                            )
                          ],
                        ),
                      ),
                      4.dpv,
                      const Text('۴ سال')
                    ],
                  ),
                ),
              ),
              ListView.separated(
                padding: 16.dpe,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                          height: 30,
                          width: 30,
                          child: ImageLoader(
                              url:
                                  'http://185.88.153.239:8000/images/WorkshopImage/638087784422316987riazi.png')),
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
                            side: const BorderSide(color: Colors.grey),
                          ),
                          onPressed: bloc.gotoDetailView,
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

class WorkBookTabUi extends StatelessWidget {
  const WorkBookTabUi({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Tab(
        child: Text(
          name,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}

BorderRadius getBorderByIndex(int index) {
  if (index == 0) {
    return const BorderRadius.only(
      topRight: Radius.circular(32.0),
      bottomRight: Radius.circular(32.0),
      topLeft: Radius.circular(4.0),
      bottomLeft: Radius.circular(4.0),
    );
  }
  if (index == 1) {
    return const BorderRadius.only(
      topLeft: Radius.circular(32.0),
      bottomLeft: Radius.circular(32.0),
      topRight: Radius.circular(4.0),
      bottomRight: Radius.circular(4.0),
    );
  }
  return BorderRadius.zero;
}
