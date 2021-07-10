import 'package:dio/dio.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockClient extends Mock implements Dio {}

class MockResponse implements Response {
  MockResponse(this.data, this.statusCode);

  @override
  var data;

  @override
  Map<String, dynamic> extra;

  @override
  Headers headers;

  @override
  bool isRedirect;

  @override
  List<RedirectRecord> redirects;

  @override
  RequestOptions requestOptions;

  @override
  int statusCode;

  @override
  String statusMessage;

  @override
  Uri get realUri => Uri.parse("http://testurl.com");
}

class MockDioError implements DioError {
  MockDioError(this.response);
  @override
  var error;

  @override
  RequestOptions requestOptions;

  @override
  Response response;

  @override
  StackTrace stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => "";
}

class MockCompteService extends Mock implements CompteService {}
