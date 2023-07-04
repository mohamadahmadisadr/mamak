import 'package:core/Notification/MyNotification.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:core/network/ApiServiceImpl.dart';
import 'package:feature/deviceInfo/my_device_info.dart';
import 'package:feature/messagingService/MessagingService.dart';
import 'package:feature/navigation/NavigationService.dart';
import 'package:feature/session/LocalSessionImpl.dart';
import 'package:get_it/get_it.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class AppModule {
  static Future<bool> initModules() async {
    // GetIt.I.registerSingleton<RouteObserver>(RouteObserver());
    GetIt.I.registerSingleton<NavigationServiceImpl>(NavigationServiceImpl());
    GetIt.I.registerSingleton<MessagingServiceImpl>(MessagingServiceImpl());
    GetIt.I.registerSingleton<LocalSessionImpl>(LocalSessionImpl());
    GetIt.I.registerSingleton<ApiServiceImpl>(ApiServiceImpl(interceptor: await GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.token)));
    GetIt.I.registerSingleton<MyNotification>(MyNotification());
    GetIt.I.registerSingleton<MyImagePicker>(MyImagePicker());
    GetIt.I.registerSingleton<MyDeviceInfo>(MyDeviceInfo());
    return true;
  }
}
