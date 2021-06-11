import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main() {
  MockSharedPreferences sharedPref;
  MockClient client;
  CompteService authService;

  Map<String, dynamic> loginResponse = <String, dynamic>{
    "user": <String, dynamic>{"id": 4, "token": "fakeToken"}
  };
  Map<String, dynamic> infosResponse = <String, dynamic>{
    "user": UserInfos(4, "test", "test", "test", false, null, null).toJson()
  };

  setUp(() {
    sharedPref = MockSharedPreferences();
    client = MockClient();
    authService = CompteService(sharedPref, client);
  });
  test("Should authenticate correctly", () async {
    when(client.post(any, data: anyNamed("data")))
        .thenAnswer((invoc) => Future(() => MockResponse(loginResponse, 200)));
    when(client.get(any))
        .thenAnswer((invoc) => Future(() => MockResponse(infosResponse, 200)));

    var future = authService.login("email", "password");

    var result = await future;
    verify(client.get(any)).called(1);
    expect(result, true);
    expect(
        verify(sharedPref.setString("userToken", captureAny)).captured.single,
        "fakeToken");
  });

  test("Should fail login", () async {
    when(client.post(any, data: anyNamed("data"))).thenAnswer((invoc) =>
        Future.delayed(Duration(milliseconds: 500),
            () => throw MockDioError(MockResponse("", 401))));

    expect(authService.login("email", "password"), throwsA(isA<DioError>()));
    verify(client.post(any, data: anyNamed("data"))).called(1);
    verifyNever(sharedPref.setString("userToken", any));
  });
}
