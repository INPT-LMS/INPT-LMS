import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/exceptions/unknown_exception.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  MockSharedPreferences sharedPref;
  MockClient client;
  var authService;

  Map<String, dynamic> loginResponse = <String, dynamic>{
    "user": <String, dynamic>{"id": 4, "token": "fakeToken"}
  };
  Map<String, dynamic> infosResponse = <String, dynamic>{
    "user": UserInfos(4, "test", "test", "test", false, null, null)
  };

  setUp(() {
    sharedPref = MockSharedPreferences();
    when(sharedPref.containsKey("userInfos")).thenReturn(false);
    when(sharedPref.containsKey("userToken")).thenReturn(false);

    client = MockClient();

    authService = CompteService(sharedPref, client);
  });
  test("Should authenticate correctly", () async {
    when(client.post(any, data: anyNamed("data"))).thenAnswer((invoc) => Future(
        () => Response(jsonEncode(loginResponse), 200,
            headers: <String, String>{"Content-Type": "application/json"})));
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer((invoc) =>
        Future(() => http.Response(jsonEncode(infosResponse), 200,
            headers: <String, String>{"Content-Type": "application/json"})));

    var future = authService.login("email", "password");

    var result = await future;
    verify(client.get(any, headers: anyNamed("headers"))).called(1);
    expect(result, true);
    expect(
        verify(sharedPref.setString("userToken", captureAny)).captured.single,
        "fakeToken");
  });

  test("Should fail login", () async {
    when(client.post(any, data: anyNamed("data"))).thenAnswer((invoc) => Future(
        () => http.Response("", 401,
            headers: <String, String>{"Content-Type": "application/json"})));

    var future = authService.login("email", "password");
    var result = await future;
    verify(client.post(any,
            body: anyNamed("body"), headers: anyNamed("headers")))
        .called(1);
    expect(result, false);
    verifyNever(sharedPref.setString("userToken", any));
  });

  test("Should throw unknown exception", () async {
    when(client.post(any, data: anyNamed("data"))).thenAnswer((invoc) => Future(
        () => http.Response("", 500,
            headers: <String, String>{"Content-Type": "application/json"})));

    var future = authService.login("email", "password");
    expect(future, throwsA(isA<UnknownException>()));
    verifyNever(client.get(any, headers: anyNamed("headers")));
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockClient extends Mock implements Dio {}
