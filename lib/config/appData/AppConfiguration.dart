import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AppConfiguration {
  static const versionCode = 15;
  static const versionName = '1.1.5';
  static const packageName = 'ir.mamakschool.mamak';

  get extraHeaders => {
        'version': versionCode.toString(),
        'platform': kIsWeb ? 'WebApp' : 'Android',
        'culture': Get.locale?.toLanguageTag() ?? 'en',
        if (!kIsWeb)
          'iWh1764CHWJuHERn++SqTsBdLkeXkTkgFr+MtRWLv6o':
              'encJw5GsbnGYNXmKtu5PiUOFPYeMX8sMDpfaZ31ksdq1KR5YtyfrvoaizJYfe866'
      };
}
