import 'package:mamak/config/apiRoute/workBook/WorkBookUrls.dart';
import 'package:mamak/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:mamak/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class ReportCardUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is WorkBookParamsModel);

    try {
      flow.emitLoading();
      var uri = createUri(
          path: WorkBookUrls.reportCard,
          body: (data as WorkBookParamsModel).toJson());

      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(workBookDetailResponseFromJson(result.result));
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
