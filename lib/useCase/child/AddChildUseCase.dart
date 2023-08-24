import 'package:mamak/config/apiRoute/child/ChildUrls.dart';
import 'package:mamak/data/body/child/AddChildBody.dart';
import 'package:mamak/presentation/viewModel/baseViewModel.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class AddChildUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is AddChildBody);

    try {
      flow.emitLoading();
      (data as AddChildBody).mobileNumber = await GetIt.I
          .get<LocalSessionImpl>()
          .getData(UserSessionConst.mobile);

      var uri = createUri(path: ChildUrls.addChild);
      var response = await apiServiceImpl.post(uri, data: jsonEncode(data));
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData('data');
          flow.throwMessage(result.concatSuccessMessages);
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
