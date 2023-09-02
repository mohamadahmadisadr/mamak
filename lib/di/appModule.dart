import 'package:core/Notification/MyNotification.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:feature/deviceInfo/my_device_info.dart';
import 'package:feature/poolakey/poolakey_helper.dart';
import 'package:mamak/presentation/translation.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class AppModule {
  static Future<void> initModules() async {
    // GetIt.I.registerSingleton<RouteObserver>(RouteObserver());
    // GetIt.I.registerSingleton<RecaptchaSolver>(RecaptchaSolver.factory());
    var keys = await MamakTranslation.getKeys();
    GetIt.I.registerSingleton(MamakTranslation(keys));
    GetIt.I.registerSingleton<NavigationServiceImpl>(NavigationServiceImpl());
    GetIt.I.registerSingleton<MessagingServiceImpl>(MessagingServiceImpl());
    GetIt.I.registerSingleton<LocalSessionImpl>(LocalSessionImpl());

    // GetIt.I.registerSingleton<RefreshTokenInterceptor>(
    //   RefreshTokenInterceptor(
    //     api: GetIt.I.get<KanoonHttp>(),
    //     failedFunc: () {
    //       GetIt.I.get<NavigationServiceImpl>().off(AppRoute.login);
    //     },
    //   ),
    // );
    // GetIt.I.registerSingleton<ApiServiceImpl>(ApiServiceImpl(
    //     interceptor: await GetIt.I
    //         .get<LocalSessionImpl>()
    //         .getData(UserSessionConst.token)));
    GetIt.I.registerSingleton<MyNotification>(MyNotification());
    GetIt.I.registerLazySingleton(() => MyImagePicker());
    GetIt.I.registerLazySingleton(() => MyDeviceInfo());
    GetIt.I.registerLazySingleton<PoolakeyHelper>(() => PoolakeyHelper());
  }
}
