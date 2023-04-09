import 'dart:io';

import 'package:core/network/NetworkImpl.dart';
import 'package:http/http.dart';

import 'ApiServiceRepository.dart';

class ApiServiceImpl extends ApiServiceRepository {
  var headers = {
    // HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
    'Access-Control-Allow-Origin': "*",
    'Access-Control-Allow-Credentials': "false",
    // "Access-Control-Allow-Methods": "GET,HEAD,OPTIONS,POST,PUT",
    // "Access-Control-Allow-Headers":
    // "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers",
  };
  final Client client = NetworkImpl().getClient();

  @override
  Future<Response> get(Uri uri) {
    return client.get(uri, headers: headers);
  }

  @override
  Future<Response> post(Uri uri) {
    return client.post(uri, headers: headers);
  }

  @override
  Future<Response> post2(Uri uri, Object body) async {
    return client.post(uri, body: body, headers: headers);
  }
}
