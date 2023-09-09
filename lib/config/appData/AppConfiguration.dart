import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConfiguration {
  static const versionCode = 16;
  static const versionName = '1.1.6';
  static const packageName = 'ir.mamakschool.mamak';

  static bool cafeBazaar = false;
  static bool multiLanguage = false;
  static Locale? forceLocale = multiLanguage ? null : const Locale('fa', 'IR');

  get extraHeaders => {
        'version': versionCode.toString(),
        'platform': kIsWeb ? 'WebApp' : 'Android',
        if (!kIsWeb)
          'UserCheck':
              'encJw5GsbnGYNXmKtu5PiUOFPYeMX8sMDpfaZ31ksdq1KR5YtyfrvoaizJYfe866'
      };
}
