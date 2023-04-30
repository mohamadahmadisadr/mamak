

import 'package:http/http.dart';

export 'ErrorModel.dart';
export 'common/ErrorMessages.dart';
export 'errorHandlerRepository.dart';

import 'ErrorHandlerImpl.dart';

class ErrorHandlerImpl extends ErrorHandlerRepository {
  @override
  ErrorModel makeError(Response response) {
    return createErrorByStatusCode(response.statusCode);
  }
  ErrorModel createErrorByStatusCode(int statusCode){
    switch (statusCode) {
      case 200:
        return const ErrorModel(
            state: ErrorState.Message, message: ErrorMessages.ErrorMessage_App);
      case 422:
        return const ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages.ErrorMessage_4_2_2);
      case 401:
        return const ErrorModel(
            state: ErrorState.UnAuthorization,
            message: ErrorMessages.ErrorMessage_4_0_1);
      case 404:
        return const ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages.NOT_FOUND);
      case 500:
        return const ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages.ErrorMessage_5_0_0);
      default:
        return const ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages.ErrorMessage_Connection);
    }
  }

  @override
  ErrorModel makeErrorByStatusCode(int statusCode) {
    return createErrorByStatusCode(statusCode);
  }

}
