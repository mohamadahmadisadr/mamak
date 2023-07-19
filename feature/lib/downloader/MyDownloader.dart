import 'dart:io' show Platform;


import 'package:feature/downloader/DownloadTaskModel.dart';
import 'package:feature/downloader/DownloadTaskStrategyRepository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:feature/downloader/androidDownloader/DownloadTaskAndroidPlatform.dart'
if (dart.library.html) 'package:core/downloader/otherDownloader/DownloadTaskWebPlatform.dart';

class MyDownloader {

  static void openUrl({required String link, type = DownloadTaskTypes.url}) {
    var model = DownloadTaskModel(type: type, link: link);
    openUrlShared(model);
  }
}
