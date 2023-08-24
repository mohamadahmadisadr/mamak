import 'package:core/Notification/MyNotification.dart';
import 'package:core/dioNetwork/interceptor/AuthorizationInterceptor.dart';
import 'package:core/dioNetwork/interceptor/RefreshTokenInterceptor.dart';
import 'package:core/dioNetwork/network.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:core/network/ApiServiceImpl.dart';
import 'package:core/recaptcha/recaptcha_solver.dart';
import 'package:feature/deviceInfo/my_device_info.dart';
import 'package:feature/poolakey/poolakey_helper.dart';
import 'package:mamak/core/network/NetworkFactory.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class AppModule {
  static Future<bool> initModules() async {
    // GetIt.I.registerSingleton<RouteObserver>(RouteObserver());
    // GetIt.I.registerSingleton<RecaptchaSolver>(RecaptchaSolver.factory());
    GetIt.I.registerSingleton<NavigationServiceImpl>(NavigationServiceImpl());
    GetIt.I.registerSingleton<MessagingServiceImpl>(MessagingServiceImpl());
    GetIt.I.registerSingleton<LocalSessionImpl>(LocalSessionImpl());
    GetIt.I.registerSingleton<KanoonDio>(NetworkFactory.createKanoonDio);
    GetIt.I.registerSingleton<KanoonHttp>(NetworkFactory.getKanoonHttp());
    GetIt.I.registerSingleton<AuthorizationInterceptor>(
        AuthorizationInterceptor(
            token: await GetIt.I
                .get<LocalSessionImpl>()
                .getData(UserSessionConst.token)));
    GetIt.I.registerSingleton<RefreshTokenInterceptor>(
      RefreshTokenInterceptor(
        api: GetIt.I.get<KanoonHttp>(),
        failedFunc: () {
          GetIt.I.get<NavigationServiceImpl>().off(AppRoute.login);
        },
      ),
    );
    GetIt.I.registerSingleton<ApiServiceImpl>(ApiServiceImpl(
        interceptor: await GetIt.I
            .get<LocalSessionImpl>()
            .getData(UserSessionConst.token)));
    GetIt.I.registerSingleton<MyNotification>(MyNotification());
    GetIt.I.registerSingleton<MyImagePicker>(MyImagePicker());
    GetIt.I.registerSingleton<MyDeviceInfo>(MyDeviceInfo());
    GetIt.I.registerLazySingleton<PoolakeyHelper>(() => PoolakeyHelper());
    return true;
  }
}
