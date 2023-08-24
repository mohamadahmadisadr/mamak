import 'package:feature/languages/english.dart';
import 'package:feature/languages/germany.dart';
import 'package:feature/languages/my_translation.dart';
import 'package:feature/languages/persian.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MamakTranslation extends Translations {
  static List<MyTranslation> languages = [
    Persian(),
    English(),
    Germany(),
  ];
  Map<String, Map<String, String>>? myKeys;

  MamakTranslation() {
    defineMyKeys();
  }

  Future<Map<String, Map<String, String>>> defineMyKeys() async {
    myKeys = {};
    await Future.forEach(languages, (lang) async {
      myKeys?[lang.getCountryCode.replaceAll('-', '_')] =
          (await lang.getTranslation);
    });
    return myKeys!;
  }

  Future<Map<String, Map<String, String>>> getKeys() async {
    return defineMyKeys();
  }

  @override
  Map<String, Map<String, String>> get keys => myKeys!;

  static List<Locale> get locales =>
      languages.map((lang) => lang.locale()).toList();
}
