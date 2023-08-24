import 'package:core/dioNetwork/interceptor/KanoonHttoInterceptor.dart';
import 'package:dio/dio.dart';

class AuthorizationInterceptor extends KanoonHttpInterceptor {
  String token;

  AuthorizationInterceptor({required this.token});

  void setToken(String newToken) => token = newToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Authorization': token});
    return handler.next(options);
  }

}
