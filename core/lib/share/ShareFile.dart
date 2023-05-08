import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';
import 'package:open_file/open_file.dart';


class ShareFile {
  static Future<ShareResult> shareFile(Uint8List bytes) {
    return Share.shareXFiles(
      [XFile.fromData(bytes, mimeType: 'application/pdf')],
      subject: 'انتخاب برای بازکردن فایل',
    );
  }

  static Future<String> saveFile(Uint8List bytes) async {
    var name = '${DateTime.now().microsecondsSinceEpoch}.pdf';
    await XFile.fromData(bytes, mimeType: 'application/pdf', name: name)
        .saveTo('/sdcard/download/$name');
    return 'sdcard/download/$name';
  }

  static void openFile(String filePath){
    OpenFile.open(filePath);
  }
}
