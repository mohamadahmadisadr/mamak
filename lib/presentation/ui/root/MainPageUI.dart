import 'package:flutter/material.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/root/RootNavigationUI.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:mamak/presentation/viewModel/main/MainViewModel.dart';

class MainPageUI extends StatefulWidget {
  const MainPageUI({Key? key}) : super(key: key);

  @override
  State<MainPageUI> createState() => _MainPageUIState();
}

class _MainPageUIState extends State<MainPageUI> {
  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => MainViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              bloc.currentIndex.toHomeNavigationEnum().getPage(),
              // if (bloc.showSecondMenu)
                AnimatedOpacity(
                  opacity: bloc.showSecondMenu ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: RootNavigationUI(
                    isShownSecondMenu: false,
                    menu: bloc.secondHomeMenu,
                    onHomeIndexChange: (p0) {},
                    currentIndex: 0,
                  ),
                )
            ],
          ),
          bottomNavigationBar: RootNavigationUI(
            menu: bloc.homeMenu,
            currentIndex: bloc.currentIndex,
            onHomeIndexChange: bloc.onIndexChange.call(),
            isShownSecondMenu: bloc.showSecondMenu,
          ),
        );
      },
    );
  }
}
