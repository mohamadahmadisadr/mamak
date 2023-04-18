import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/presentation/ui/main/MamakTitle.dart';
import 'package:mamak/presentation/viewModel/workBook/MotherWorkBookViewModel.dart';

class MothersWorkBookUi extends StatelessWidget {
  const MothersWorkBookUi({Key? key}) : super(key: key);

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
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    MamakTitle(title: 'کارنامه'),
                    TabBar(
                      tabs: [
                        Tab(
                          child: Text('tab1'),
                        ),
                        Tab(
                          child: Text('tab2'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
