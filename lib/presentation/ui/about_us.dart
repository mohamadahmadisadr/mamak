import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:mamak/data/serializer/home/HomeResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/home/HomeViewModel.dart';

import 'main/ConditionalUI.dart';
import 'main/CubitProvider.dart';

class AboutUsUi extends StatelessWidget {
  const AboutUsUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (_) => HomeViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<HomeResponse>(
          onSuccess: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                8.dpv,
                const Text(
                  'درباره ما',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                8.dpv,
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: ImageLoader(url: 'data'),
                )
              ],
            );
          },
          state: state,
        );
      },
    );
  }
}
