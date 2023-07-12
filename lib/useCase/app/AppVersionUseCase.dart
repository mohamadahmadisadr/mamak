import 'package:mamak/config/apiRoute/app/AppUrls.dart';
import 'package:mamak/config/appData/AppConfiguration.dart';
import 'package:mamak/data/body/app/AppVersionResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class AppVersionUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();

      var uri = createUri(path: AppUrls.isThereNewAppVersion,body: {'currentAppVersionId':AppConfiguration.versionCode.toString()});

      var response = await apiServiceImpl.get(uri);
      Logger.d(response.body);

      if (response.isSuccessful) {
        var result = response.result;

        if (result.isSuccessFull) {

          flow.emitData(result.result == 'true');
        } else {
          flow.throwMessage(result.concatErrorMessages);
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch();
    }
  }
}
