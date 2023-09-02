import 'package:core/dioNetwork/interceptor/AuthorizationInterceptor.dart';
import 'package:core/dioNetwork/interceptor/culture_interceptor.dart';
import 'package:core/dioNetwork/network.dart';
import 'package:get/get.dart';
import 'package:mamak/core/network/NetworkFactory.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class NetworkModule {
  static Future<void> initNetworkModule() async {
    GetIt.I.registerSingleton<KanoonDio>(NetworkFactory.createKanoonDio);
    GetIt.I.registerSingleton<KanoonHttp>(NetworkFactory.getKanoonHttp());
    GetIt.I.registerSingleton(
        CultureInterceptor(culture: Get.locale?.toLanguageTag() ?? ''));
    GetIt.I.registerSingleton(AuthorizationInterceptor(
        token: await GetIt.I
            .get<LocalSessionImpl>()
            .getData(UserSessionConst.token)));
  }
}
