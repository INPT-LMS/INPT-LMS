import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/model/course/visibility_data.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/exceptions/authentication_exception.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  MockSharedPreferences sharedPref;
  MockClient client;
  CourseService courseService;

  var cours = CourseData("fakeIdCours", "Mon fake cours", "Cours de test", null,
      Visibility(0, "PUBLIC"));

  setUp(() {
    sharedPref = MockSharedPreferences();
    when(sharedPref.containsKey("userToken")).thenReturn(true);
    when(sharedPref.getString("userToken")).thenReturn("fakeToken");

    client = MockClient();

    courseService = CourseService(sharedPref, client);
  });

  test("Should get course correctly", () async {
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer((invoc) =>
        Future(() => http.Response(jsonEncode(cours), 200,
            headers: <String, String>{"Content-Type": "application/json"})));

    var coursExpected = await courseService.getCours("fakeIdCours");

    verify(client.get(any, headers: anyNamed("headers"))).called(1);
    verify(sharedPref.getString("userToken")).called(1);
    expect(coursExpected.courseID, cours.courseID);
  });

  test("Should throw authentication exception", () async {
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer(
        (invoc) => Future(() => http.Response("UNAUTHORIZED", 200)));

    var future = courseService.getCours("fakeIdCours");

    verify(client.get(any, headers: anyNamed("headers"))).called(1);
    expect(future, throwsA(isA<AuthenticationException>()));
  });

  test("Should throw authentication exception no token", () async {
    when(sharedPref.containsKey("userToken")).thenReturn(false);

    var future = courseService.getCours("fakeIdCours");

    verifyNever(client.get(any, headers: anyNamed("headers")));
    expect(future, throwsA(isA<AuthenticationException>()));
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockClient extends Mock implements http.Client {}
