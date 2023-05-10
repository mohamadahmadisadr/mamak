import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:mamak/config/appData/AppConfiguration.dart';
import 'package:mamak/data/body/app/AppVersionResponse.dart';
import 'package:mamak/data/serializer/user/GetUserProfileResponse.dart';
import 'package:mamak/di/appModule.dart';
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
    checkVersion();
  }

  static AppViewModel getInstance = AppViewModel(AppState.idle);

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
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
      if (appState.isSuccess) {
        if (appState.getData is AppVersionResponse) {
          AppVersionResponse appVersion = appState.getData;
          int version = int.tryParse(appVersion.versionNumber ?? '0') ?? 0;
          if (version > AppConfiguration.versionCode) {
            GetIt.I
                .get<NavigationServiceImpl>()
                .dialog(UpdateDialog(link: appVersion.linkUrl ?? ''));
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
}
