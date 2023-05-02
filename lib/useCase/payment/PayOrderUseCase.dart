import 'package:mamak/config/apiRoute/payment/PayOrderUrls.dart';
import 'package:mamak/data/serializer/subscribe/PayOrderResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class PayOrderUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();

      var uri = createUri(path: PayOrderUrls.payOrder);

      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;

        if (result.isSuccessFull) {
          flow.emitData(result.result.replaceAll('"', ""));
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
