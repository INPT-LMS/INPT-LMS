import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:lms_flutter/services/exceptions/authentication_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exceptions/network_exception.dart';

class CourseService extends BaseService {
  CourseService(SharedPreferences sharedPreferences, http.Client client)
      : super(sharedPreferences, client);

  Future<CourseData> getCours(String idCours) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/class/course/$idCours");
    return client
        .get(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) {
      var responseBody = handleException(response);
      if (responseBody == "UNAUTHORIZED") throw new AuthenticationException();
      return CourseData.fromJson(jsonDecode(responseBody));
    });
  }
}
