import 'package:mamak/presentation/viewModel/baseViewModel.dart';

class SplashViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  SplashViewModel(super.initialState){
    initSplash();
  }

  void initSplash() {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      if (await loggedIn) {
        _navigationServiceImpl.replaceTo(AppRoute.home);
      } else {
        _navigationServiceImpl.replaceTo(AppRoute.login);
      }
    });
  }

  Future<bool> get loggedIn async =>
      await session.getData(UserSessionConst.id) != '';
}
