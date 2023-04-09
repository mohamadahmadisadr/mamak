import 'package:feature/messagingService/MessagingService.dart';
import 'package:feature/navigation/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppModule {
  static Future<bool> initModules() async {
    GetIt.I.registerSingleton<RouteObserver>(RouteObserver());
    // GetIt.I.registerSingleton<Client>(NetworkImpl().getClient());
    GetIt.I.registerSingleton<NavigationServiceImpl>(NavigationServiceImpl());
    GetIt.I.registerSingleton<MessagingServiceImpl>(MessagingServiceImpl());
    // GetIt.I.registerSingleton<ApiServiceImpl>(ApiServiceImpl());
    // GetIt.I.registerSingleton<LocalSessionImpl>(LocalSessionImpl());
    // GetIt.I.registerSingleton<MyNotification>(MyNotification());
    return true;
  }
}
