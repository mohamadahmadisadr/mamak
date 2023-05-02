import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MyLoader.dart';
import 'package:mamak/presentation/viewModel/app/ShotViewViewModel.dart';

class ShotViewerUi extends StatelessWidget {
  const ShotViewerUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ShotViewerViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.save_alt))
            ],
          ),
          body: bloc.bytes != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.memory(bloc.bytes!),
                  ),
                )
              : const Center(
                  child: MyLoader(),
                ),
        );
      },
    );
  }
}
