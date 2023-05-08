import 'dart:io';

import 'package:core/fileSaver/AndroidFileSaver.dart';
import 'package:core/share/ShareFile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/file/DownloadFileUseCase.dart';
import 'package:core/fileSaver/WebFileSaver.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class DownloadFileViewModel extends BaseViewModel {
  DownloadFileViewModel(super.initialState);

  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  void downloadFile(String fileName) {
    DownloadFileUseCase().invoke(MyFlow(
      flow: (appState) async{
        print(appState);
        if (appState.isSuccess) {
          var data = appState.getData;

          if(kIsWeb){
            WebFileSaver.saveFile(data);
          }else{
            var path = await ShareFile.saveFile(data);
            ShareFile.openFile(path);
          }

          _navigationServiceImpl.pop();
          // _navigationServiceImpl.navigateTo(AppRoute.shotViewer, data);
        }
      },
    ), data: fileName);
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }

  }
}
