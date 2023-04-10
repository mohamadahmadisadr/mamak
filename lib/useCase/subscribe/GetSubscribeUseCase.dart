import 'package:http/http.dart';
import 'package:mamak/config/apiRoute/subscribe/SubscribeUrls.dart';
import 'package:mamak/data/serializer/subscribe/SubscribesResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class GetSubscribeUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();
      Uri uri = createUri(path: SubscribeUrls.getSubscribe);
      Response response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        List<SubscribeItem> subscribeResponse =
            subscribesResponseFromJson(response.body);
        flow.emitData(subscribeResponse);
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      flow.throwCatch();
    }
  }
}
