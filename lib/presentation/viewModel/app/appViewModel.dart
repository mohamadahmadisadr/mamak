import 'package:core/dioNetwork/interceptor/AuthorizationInterceptor.dart';
import 'package:core/dioNetwork/interceptor/RefreshTokenInterceptor.dart';
import 'package:core/dioNetwork/kanoonHttp/KanoonHttp.dart';
import 'package:core/utils/logger/Logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mamak/data/serializer/user/GetUserProfileResponse.dart';
import 'package:mamak/di/appModule.dart';
import 'package:mamak/presentation/translation.dart';
import 'package:mamak/presentation/ui/dialog/UpdateDialog.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/app/AppVersionUseCase.dart';
import 'package:mamak/useCase/user/GetUserProfileUseCase.dart';

class AppViewModel extends Cubit<AppState> {
  AppViewModel(super.initialState) {
    initAppData();
  }

  void initAppData() async {
    await AppModule.initModules();
    await defineTranslations();
    await initInterceptors();
    if (!kIsWeb) {
      checkVersion();
    }
  }

  static AppViewModel getInstance = AppViewModel(AppState.idle);

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
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

  void getUseData() {
    GetUserProfileUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is GetUserProfileResponse) {
        GetUserProfileResponse res = appState.getData;
        if (res.userAvatar?.content != null) {
          GetIt.I
              .get<LocalSessionImpl>()
              .insertData({UserSessionConst.image: res.userAvatar!.content!});
        }
      }
    }));
  }

  void checkVersion() {
    AppVersionUseCase().invoke(MyFlow(flow: (appState) {
      Logger.d(appState);
      if (appState.isSuccess) {
        if (appState.getData is bool) {
          if (appState.getData == true) {
            GetIt.I.get<NavigationServiceImpl>().dialog(
                  const UpdateDialog(
                      link:
                          'https://back.mamakschool.ir/api/AppVersion/GetLatestAppVersionFile'),
                );
          }
        }
      }
    }));
  }

  @override
  Future<void> close() {
    GetIt.I.get<Client>().close();
    return super.close();
  }

  defineTranslations() async{
    var keys = await MamakTranslation().getKeys();
    Get.addTranslations(keys);
  }
}
