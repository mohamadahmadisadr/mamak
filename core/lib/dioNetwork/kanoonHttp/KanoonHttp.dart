import 'package:core/dioNetwork/interceptor/KanoonHttoInterceptor.dart';
import 'package:core/dioNetwork/kanoonHttp/KanoonHttpRequests.dart';
import 'package:core/dioNetwork/kanoonHttp/shared_adapter.dart';
import 'package:core/dioNetwork/response/KanoonHttpResponse.dart';
import 'package:dio/dio.dart';

class KanoonDio with DioMixin implements Dio {
  KanoonDio(
      {BaseOptions? baseOptions,
      bool logEnable = false,
      Map<String, String>? extraHeaders}) {
    options = baseOptions ?? BaseOptions();
    httpClientAdapter = getAdapter();
    if (logEnable) {
      interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    if (extraHeaders != null && extraHeaders.isNotEmpty) {
      options.headers.addAll(extraHeaders);
    }
  }

  static Options get fileOptions => Options(responseType: ResponseType.bytes);
}

class KanoonHttp implements KanoonHttpRequests {
  KanoonDio kanoonDio;

  KanoonHttp(this.kanoonDio);

  @override
  Future<KanoonHttpResponse> get<T>(Uri uri, {Options? options}) async {
    return (await kanoonDio.getUri<T>(uri, options: options))
        .createKanoonResponse;
  }

  @override
  Future<KanoonHttpResponse> post(Uri uri,
      {Object? data, Options? options}) async {
    return (await kanoonDio.postUri(uri, data: data, options: options))
        .createKanoonResponse;
  }

  void addInterceptor(KanoonHttpInterceptor interceptor) {
    if (!kanoonDio.interceptors.contains(interceptor)) {
      kanoonDio.interceptors.add(interceptor);
    }
  }

  @override
  Future<Response<dynamic>> request(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return kanoonDio.request(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
  }
}
