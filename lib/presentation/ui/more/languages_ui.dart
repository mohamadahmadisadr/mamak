import 'package:feature/session/LocalSessionImpl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mamak/common/user/UserSessionConst.dart';
import 'package:mamak/presentation/translation.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';

class LanguagesUi extends StatelessWidget {
  const LanguagesUi({super.key});

  @override
  Widget build(BuildContext context) {
    return MamakScaffold(
        body: Column(
      children: MamakTranslation.languages
          .map(
            (lang) => ListTile(
              title: Text(lang.getCountryName),
              leading: Checkbox(value: Get.locale == lang.locale(), onChanged: (value) {
                  Get.updateLocale(lang.locale());
                  GetIt.I.get<LocalSessionImpl>().insertData({UserSessionConst.lang:lang.getCountryName});
              },),
            ),
          )
          .toList(),
    ));
  }
}
