import 'package:badges/badges.dart' as badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:mamak/presentation/uiModel/bottomNavigation/model/MoreNavigationModel.dart';
import 'package:mamak/presentation/viewModel/main/MainViewModel.dart';

class RootNavigationUI extends StatelessWidget {
  const RootNavigationUI({
    Key? key,
    required this.menu,
    required this.onHomeIndexChange,
    required this.currentIndex,
    required this.isShownSecondMenu,
  }) : super(key: key);
  final List<HomeNavigationModel> menu;
  final Function(int) onHomeIndexChange;
  final int currentIndex;
  final bool isShownSecondMenu;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      elevation: .5,
      backgroundColor: Colors.grey.shade50,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      selectedItemColor: context.theme.primaryColor,
      items: menu
          .map(
            (hbnI) => BottomNavigationBarItem(
              icon: hbnI is MoreNavigationModel
                  ? MoreIconButton(
                      isShownSecondMenu: isShownSecondMenu,
                    )
                  : badge.Badge(
                      badgeContent: Text(hbnI.getBadge,
                          style: const TextStyle(color: Colors.white)),
                      showBadge: (hbnI.getBadge.isBlank == false),
                      child: Icon(hbnI.getIcon),
                    ),
              label: hbnI.getName,
            ),
          )
          .toList(),
      currentIndex: currentIndex,
      onTap: onHomeIndexChange,
    );
  }
}

class MoreIconButton extends StatefulWidget {
  const MoreIconButton({Key? key, required this.isShownSecondMenu})
      : super(key: key);
  final bool isShownSecondMenu;

  @override
  State<MoreIconButton> createState() => _MoreIconButtonState();
}

class _MoreIconButtonState extends State<MoreIconButton>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<MainViewModel>().animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    context.read<MainViewModel>().animationController?.dispose();
    context.read<MainViewModel>().animationController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0)
          .animate(context.read<MainViewModel>().animationController!),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1.5)),
        child: const Icon(
          CupertinoIcons.chevron_up,
          color: Colors.black,
        ),
      ),
    );
  }
}
