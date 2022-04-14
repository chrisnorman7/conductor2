import 'package:dio/dio.dart';

import 'json/app_credentials.dart';

final _dio = Dio();

/// Get the given url [path].
Future<Response<Map<String, dynamic>>> get({
  required final AppCredentials credentials,
  required final String path,
  final Map<String, String>? params,
}) async {
  final urlParams = params ?? {};
  urlParams['app_id'] = credentials.id;
  urlParams['app_key'] = credentials.key;
  final uri = Uri.https('transportapi.com', 'v3/uk/$path', urlParams);
  return _dio.get(uri.toString());
}
