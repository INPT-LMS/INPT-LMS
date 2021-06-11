import 'package:dio/dio.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:lms_flutter/services/exceptions/forbidden_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service chargé des interactions liées aux cours
class CourseService extends BaseService {
  CourseService(SharedPreferences sharedPreferences, Dio client)
      : super(sharedPreferences, client);

  Future<CourseData> getCours(String idCours) {
    return client.get("/class/course/$idCours").then((response) {
      if (response.data.toString() == "UNAUTHORIZED")
        throw ForbiddenException();
      return CourseData.fromJson(response.data);
    });
  }

  Future<int> getCoursOwner(String idCours) {
    return client.get("/class/course/$idCours/owner").then((response) {
      var responseBody = response.data.toString();
      if (responseBody == "UNAUTHORIZED") throw ForbiddenException();
      return int.parse(responseBody);
    });
  }
}
