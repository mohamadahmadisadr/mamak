import 'package:mamak/config/apiRoute/home/HomeUrls.dart';
import 'package:mamak/data/serializer/home/PackageDetailResponse.dart';
import 'package:mamak/useCase/BaseUseCase.dart';

class GetPackagesDetailUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is String);
    try {
      flow.emitLoading();
      var uri = createUri(
          path: HomeUrls.getPackageDetails,
          body: {'packageId': data.toString()});

      var response = await apiServiceImpl.get(uri);
      if(response.isSuccessful){
        
        var result = response.result;
        if(result.isSuccessFull){
          flow.emitData(packageDetailResponseFromJson(result.result));
        }else{
          flow.throwMessage(result.concatErrorMessages);
        }
      }else{
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch();
    }
  }
}
