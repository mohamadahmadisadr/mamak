import 'package:feature/session/LocalSessionImpl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mamak/common/user/UserSessionConst.dart';
import 'package:mamak/presentation/translation.dart';

class AppDefaultLocale {
  static Locale? staticLocale = const Locale('fa','IR');
  static Locale getAppLocale = staticLocale ??
      Get.locale ?? Get.deviceLocale ?? MamakTranslation.locales.first;
  static Locale fallBackLocale = staticLocale ?? MamakTranslation.locales.first;
  static List<Locale> supportedLocale = MamakTranslation.locales;
  static List<LocalizationsDelegate> localizationDelegate = const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static Future<Locale> setLocaleFromSession() async {
    var currentLang =
        await GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.lang);
    return staticLocale ?? MamakTranslation.languages
            .firstWhereOrNull((lang) => lang.getCountryName == currentLang)
            ?.locale() ??
        getAppLocale;
  }
}
