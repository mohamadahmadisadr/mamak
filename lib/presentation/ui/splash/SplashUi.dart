import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/config/appData/appTheme/MyTheme.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/MamakLogo.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/user/SplashViewModel.dart';

class SplashUi extends StatelessWidget {
  const SplashUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => SplashViewModel(AppState.idle),
      builder: (bloc, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                MyTheme.purple.withOpacity(.5),
                MyTheme.purple
              ],
              focalRadius: .5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: 16.dpe,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: Text(
                  'کودک خود را بشناسید!',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              16.dpv,
              const MamakLogo()
            ],
          ),
        );
      },
    );
  }
}
