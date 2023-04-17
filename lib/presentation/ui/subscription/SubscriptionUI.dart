import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/Home/HomeAppbar.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/subscription/SubscriptionViewModel.dart';

class SubscriptionUI extends StatelessWidget {
  const SubscriptionUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => SubscriptionViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI(
          state: state,
          onSuccess: (data) {
            return Scaffold(
              appBar: AppBar(
                flexibleSpace: const HomeAppBar(),
              ),
              body: Padding(
                padding: 8.dpe,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [],
                ),
              ),
            );
          },
        );
      },
    );
  }
}