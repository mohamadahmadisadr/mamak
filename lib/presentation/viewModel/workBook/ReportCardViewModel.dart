import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/workBook/ReportCardUseCase.dart';

class ReportCardViewModel extends BaseViewModel {
  final key = GlobalKey();
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  WorkBookParamsModel? model;

  ReportCardViewModel(super.initialState) {
    getExtra();
  }

  void getExtra() {
    model = _navigationServiceImpl.getArgs();
    if (model != null && model is WorkBookParamsModel) {
      getReportCard(model!);
    }
  }

  void getReportCard(WorkBookParamsModel model) {
    ReportCardUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is WorkBookDetailResponse) {
        mainFlow.emit(AppState.success(
            (appState.getData as WorkBookDetailResponse).createUiModel(model)));
      } else {
        mainFlow.emit(appState);
      }
    }), data: model);
  }

  Future<Uint8List?> takeSnapShot() async {
    final RenderRepaintBoundary boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  void getWorkBookShot() async {
    var data = await takeSnapShot();
    if (data != null) {
      _navigationServiceImpl.navigateTo(AppRoute.shotViewer, data);
    } else {
      messageService.showSnackBar('خطا در دریاقت کارنامه');
    }
  }
}
