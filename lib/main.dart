import 'package:feature/messagingService/MessagingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:url_strategy/url_strategy.dart';

import 'config/appData/appTheme/AppTheme.dart';
import 'config/appData/locales/AppDefaultLocale.dart';
import 'config/appData/route/AppRoute.dart';
import 'config/appData/route/AppRouteHelper.dart';
import 'presentation/viewModel/app/appViewModel.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark));
  setPathUrlStrategy();
  runApp(
    BlocBuilder(
      builder: (context, state) => const MyApp(),
      bloc: AppViewModel.getInstance,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoute.login,
      darkTheme: AppTheme.myTheme(),
      getPages: AppRouteHelper.router,
      title: 'Mamak',
      theme: AppTheme.myTheme(),
      locale: AppDefaultLocale.getAppLocale,
      supportedLocales: AppDefaultLocale.supportedLocale,
      localizationsDelegates: AppDefaultLocale.localizationDelegate,
      localeResolutionCallback: (_, __) => AppDefaultLocale.getAppLocale,
      builder: rootTransitionBuilder(),
      scaffoldMessengerKey: GetIt.I.get<MessagingServiceImpl>().messageService,
    );
  }

  TransitionBuilder rootTransitionBuilder() {
    return (context, child) => Scaffold(body: child);
  }
}
