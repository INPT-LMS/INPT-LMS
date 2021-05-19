import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/consts/base_url.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/model/user_register_form.dart';
import 'package:lms_flutter/services/exceptions/authentication_exception.dart';
import 'package:lms_flutter/services/exceptions/not_found_exception.dart';
import 'package:lms_flutter/services/exceptions/unknown_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  SharedPreferences sharedPreferences;
  UserInfos userInfos;
  String userToken;
  AuthService(this.sharedPreferences) {
    userInfos = sharedPreferences.containsKey("userInfos")
        ? UserInfos.fromJson(
            jsonDecode(sharedPreferences.getString("userInfos")))
        : null;
    userToken = sharedPreferences.containsKey("userToken")
        ? sharedPreferences.getString("userToken")
        : null;
  }

  Future<bool> login(String email, String password) {
    int userId;
    return http
        .post(Uri.parse(BaseUrl.URL_GATEWAY + "/account/auth"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode(
                <String, String>{"email": email, "password": password}))
        .then((response) {
      switch (response.statusCode) {
        case 200:
          var body = jsonDecode(response.body)["user"];
          userId = body["id"];
          sharedPreferences.setString("userToken", body["token"]);

          return http.get(
              Uri.parse(BaseUrl.URL_GATEWAY + "/account/user/$userId"),
              headers: <String, String>{"Content-Type": "application/json"});
          break;
        case 400:
          throw AuthenticationException();
          break;
        case 404:
          throw NotFoundException();
          break;
        default:
          throw UnknownException();
      }
    }).then((response) {
      if (response.statusCode == 200) {
        var infos = UserInfos.fromJson(jsonDecode(response.body)["user"]);
        infos.id = userId;
        sharedPreferences.setString("userInfos", jsonEncode(infos));
        return true;
      } else {
        sharedPreferences.remove("userToken");
        return false;
      }
    }, onError: (e) {
      sharedPreferences.remove("userToken");
      return false;
    });
  }

  Future<http.Response> register(UserRegisterForm form) {
    return http.post(Uri.parse(BaseUrl.URL_GATEWAY + "/account/register"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(form));
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey("userToken") &&
        sharedPreferences.containsKey("userInfos");
  }

  void logout() {
    sharedPreferences.remove("userToken");
    sharedPreferences.remove("userInfos");
  }
}
