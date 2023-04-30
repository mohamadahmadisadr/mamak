
import 'package:core/network/errorHandler/ErrorModel.dart';
import 'package:http/http.dart';

abstract class ErrorHandlerRepository {
  ErrorModel makeError(Response response);
  ErrorModel makeErrorByStatusCode(int statusCode);
}
