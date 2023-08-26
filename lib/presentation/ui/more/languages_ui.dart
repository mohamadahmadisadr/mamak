import 'package:core/dioNetwork/interceptor/AuthorizationInterceptor.dart';
import 'package:core/dioNetwork/interceptor/RefreshTokenInterceptor.dart';
import 'package:core/dioNetwork/kanoonHttp/KanoonHttp.dart';
import 'package:core/utils/flow/MyFlow.dart';
import 'package:feature/session/LocalSessionImpl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mamak/common/user/UserSessionConst.dart';
import 'package:mamak/core/network/NetworkFactory.dart';
import 'package:mamak/presentation/translation.dart';
import 'package:mamak/presentation/ui/main/MamakScaffold.dart';
import 'package:mamak/useCase/app/set_culture_use_case.dart';

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
              leading: Checkbox(
                value: Get.locale == lang.locale(),
                onChanged: (value) async{
                  Get.updateLocale(lang.locale());
                  GetIt.I
                      .get<LocalSessionImpl>()
                      .insertData({UserSessionConst.lang: lang.getCountryName});
                  SetCultureUseCase().invoke(MyFlow(flow: (state) {}),
                      data: lang.getCountryCode);
                  GetIt.I.unregister<KanoonDio>();
                  GetIt.I.unregister<KanoonHttp>();
                  GetIt.I.registerSingleton<KanoonDio>(NetworkFactory.createKanoonDio);
                  GetIt.I.registerSingleton<KanoonHttp>(NetworkFactory.getKanoonHttp());
                  await initInterceptors();
                },
              ),
            ),
          )
          .toList(),
    ));


  }

  Future<bool> initInterceptors() async {
    GetIt.I
        .get<KanoonHttp>()
        .addInterceptor(GetIt.I.get<AuthorizationInterceptor>());
    GetIt.I
        .get<KanoonHttp>()
        .addInterceptor(GetIt.I.get<RefreshTokenInterceptor>());
    // RefreshTokenInterceptorUseCase().invoke();

    return Future.value(true);
  }
}
