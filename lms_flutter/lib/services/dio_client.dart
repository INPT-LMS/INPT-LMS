import 'package:dio/dio.dart';
import 'package:lms_flutter/model/consts.dart';

Dio getDioClient() {
  return Dio(BaseOptions(
      baseUrl: Consts.URL_GATEWAY,
      connectTimeout: Consts.TIMEOUT_REQUEST,
      setRequestContentTypeWhenNoPayload: true));
}

void setupDioClient(Dio dio, String token) {
  dio.options.headers = <String, String>{"Authorization": "Bearer $token"};
}
