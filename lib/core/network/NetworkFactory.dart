import 'package:core/dioNetwork/network.dart';
import 'package:get_it/get_it.dart';
import 'package:mamak/config/appData/AppConfiguration.dart';

class NetworkFactory {
  static KanoonDio get createKanoonDio => KanoonDio(
        logEnable: true,
        extraHeaders: AppConfiguration().extraHeaders,
      );

  static KanoonHttp getKanoonHttp(KanoonDio dio) {
    if (GetIt.I.isRegistered<KanoonDio>()) {
      return KanoonHttp(dio);
    } else {
      throw Exception(
          'Kanoon dio should be registered in get_it before the instance of kanoon http');
    }
  }
}
