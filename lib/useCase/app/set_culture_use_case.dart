import 'package:mamak/config/apiRoute/app/AppUrls.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class SetCultureUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is String);

    var uri =
        createUri(path: AppUrls.setCurrentCulture, body: {'culture': data});

    try {
      var response = await apiServiceImpl.post(uri);
      if (response.isSuccessful) {
        flow.emitData('');
      } else {
        flow.throwError(response);
      }
    } on Exception catch (e, s) {
      flow.throwCatch();
      Logger.d(s);
    }
  }
}
