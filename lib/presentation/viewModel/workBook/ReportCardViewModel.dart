import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mamak/config/apiRoute/BaseUrls.dart';
import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/ui/workBook/DownloadFileDialog.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/workBook/ReportCardUseCase.dart';
import 'package:url_launcher/url_launcher.dart';

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
      print('model is ${model?.toJson()}');
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
    if (model != null) {
      String path =
          'https://${BaseUrls.baseUrl}/report/card/download/${model?.userChildId}/${model?.workShopId}/${Get.locale?.toLanguageTag()}';
      _launchUrl(path);
    } else {
      messageService.showSnackBar('fail_receive_report_card'.tr);
    }
  }

  void getLastWorkBook() async {
    if (model != null) {
      String path =
          'https://${BaseUrls.baseUrl}/report/card/download/${model?.userChildId}/${model?.lastWorkShopId}/${Get.locale?.toLanguageTag()}';
      _launchUrl(path);
    } else {
      messageService.showSnackBar('fail_receive_report_card'.tr);
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  onSolutionItemClick(WorkBookDetailReviews item) {
    if (item.fileDataId != null) {
      _navigationServiceImpl
          .dialog(DownloadFileDialog(fileDataId: item.fileDataId!));
    }
  }
}
