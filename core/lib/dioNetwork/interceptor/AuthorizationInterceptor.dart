import 'package:core/dioNetwork/interceptor/KanoonHttoInterceptor.dart';
import 'package:core/utils/logger/Logger.dart';
import 'package:dio/dio.dart';

class AuthorizationInterceptor extends KanoonHttpInterceptor {
  String token;
  Function? onFailAuth;

  AuthorizationInterceptor({required this.token, this.onFailAuth});

  void setToken(String newToken) {
    Logger.d('setting new token is $newToken');
    token = newToken;
  }

  void setOnFailAuth(Function onFailAuth) {
    this.onFailAuth = onFailAuth;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Authorization': token});
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      onFailAuth?.call();
    }
    super.onResponse(response, handler);
  }
}
