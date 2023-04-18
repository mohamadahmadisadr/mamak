import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class MotherWorkBookViewModel extends BaseViewModel implements TickerProvider {
  late TabController tabController;

  MotherWorkBookViewModel(super.initialState) {
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    throw UnimplementedError();
  }
}
