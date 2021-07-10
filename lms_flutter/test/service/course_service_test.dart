import 'package:flutter_test/flutter_test.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/model/course/visibility_data.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/exceptions/forbidden_exception.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  MockSharedPreferences sharedPref;
  MockClient client;
  CourseService courseService;
  CompteService compteService;

  var cours = CourseData("fakeIdCours", "Mon fake cours", "Cours de test", null,
      Visibility(0, "PUBLIC"));

  setUp(() {
    sharedPref = MockSharedPreferences();
    client = MockClient();
    compteService = CompteService(sharedPref, client);
    getIt.registerSingleton(compteService);
    courseService = CourseService(sharedPref, client);
  });

  tearDown(() {
    getIt.unregister(instance: compteService);
  });

  test("Should get course correctly", () async {
    when(client.get(any))
        .thenAnswer((invoc) => Future(() => MockResponse(cours.toJson(), 200)));

    var coursExpected = await courseService.getCours("fakeIdCours");

    verify(client.get(any)).called(1);
    expect(coursExpected.courseID, cours.courseID);
  });

  test("Should throw authentication exception", () async {
    when(client.get(any))
        .thenAnswer((invoc) => Future(() => MockResponse("UNAUTHORIZED", 200)));

    expect(courseService.getCours("fakeIdCours"),
        throwsA(isA<ForbiddenException>()));
    verify(client.get(any)).called(1);
  });
}
