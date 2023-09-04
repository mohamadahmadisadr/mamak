import 'package:core/dioNetwork/interceptor/AuthorizationInterceptor.dart';
import 'package:core/dioNetwork/interceptor/culture_interceptor.dart';
import 'package:get/get.dart';
import 'package:mamak/core/network/NetworkFactory.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

var sl = GetIt.instance;

class NetworkModule {
  static Future<void> initNetworkModule() async {
    sl.registerLazySingleton(() => NetworkFactory.createKanoonDio);
    sl.registerLazySingleton(() => NetworkFactory.getKanoonHttp(sl()));
    sl.registerLazySingleton(
        () => CultureInterceptor(culture: Get.locale?.toLanguageTag() ?? ''));
    var token =
        await sl.get<LocalSessionImpl>().getData(UserSessionConst.token);
    sl.registerLazySingleton(() => AuthorizationInterceptor(token: token));
  }
}
