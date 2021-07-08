import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lms_flutter/model/add_course_form.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/model/course/member.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/exceptions/forbidden_exception.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service chargé des interactions liées aux cours
class CourseService extends BaseService {
  CourseService(SharedPreferences sharedPreferences, Dio client)
      : super(sharedPreferences, client){
   compteService = getIt.get<CompteService>();
  }
  CompteService compteService  ;
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

  Future<CourseData> addCourse(AddCourseForm courseData) {
    return client
        .post("/class/course/owner", data: courseData.toJson())
        .then((value) {
      return CourseData.fromJson(value.data);
    });
  }

  Future<List<CourseData>> getCourses() {
    return client.get("/class/student/courses").then((response) {
      List responseBody = response.data;
      List<CourseData> courses = new List.empty(growable: true);
      for (int i = 0; i < responseBody.length; i++) {
        courses.add(CourseData.fromJson(responseBody[i]));
      }
      return courses;
    }).catchError((err) {
      log(err.toString());
    });
  }

  Future<List<UserInfos>> getCourseMembers(String courseID){
    return client.get("/class/course/$courseID/members").then((response){

      List responseBody = response.data;
      List<UserInfos> courseMembers = new List.empty(growable: true);
      for (int i = 0; i < responseBody.length; i++) {
        Member mem = Member.fromJson(responseBody[i]);
        compteService.getUserInfos(mem.memberID).then((value) {
          courseMembers.add(value);
        });

        return courseMembers;
      }



      return courseMembers ;
    }).catchError((err){
      log("Erorr");
    });
  }
}
