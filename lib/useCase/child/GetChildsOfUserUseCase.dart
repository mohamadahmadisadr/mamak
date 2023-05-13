import 'package:mamak/config/apiRoute/child/ChildUrls.dart';
import 'package:mamak/data/serializer/child/ChildsResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class GetChildOfUserUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();

      var uri = createUri(path: ChildUrls.getChilds);
      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(childsItemFromJson(result.resultsList));
        } else {
          if (result.resultCode == 204) {
            flow.throwEmptyDataMessage(result.concatErrorMessages);
          } else {
            flow.throwMessage(result.concatErrorMessages);
          }
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
