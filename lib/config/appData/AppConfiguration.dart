import 'package:flutter/foundation.dart';

class AppConfiguration {
  static const versionCode = 15;
  static const versionName = '1.1.5';
  static const packageName = 'ir.mamakschool.mamak';

  static get extraHeaders => {
        'version': versionCode.toString(),
        'platform': kIsWeb ? 'WebApp' : 'Android',
        if (!kIsWeb)
          'iWh1764CHWJuHERn++SqTsBdLkeXkTkgFr+MtRWLv6o':
              'encJw5GsbnGYNXmKtu5PiUOFPYeMX8sMDpfaZ31ksdq1KR5YtyfrvoaizJYfe866'
      };
}
