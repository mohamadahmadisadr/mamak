import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

HttpClientAdapter getAdapter() {
  // IOHttpClientAdapter().createHttpClient = () {
  //   return HttpClient(context: SecurityContext.defaultContext);
  // };
  return IOHttpClientAdapter()
    ..onHttpClientCreate = (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
}
