import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/model/user_register_form.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:lms_flutter/services/exceptions/authentication_exception.dart';
import 'package:lms_flutter/services/exceptions/not_found_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends BaseService {
  AuthService(SharedPreferences sharedPreferences, http.Client client)
      : super(sharedPreferences, client);

  Future<bool> login(String email, String password) {
    int userId;
    return client
        .post(Uri.parse(Consts.URL_GATEWAY + "/account/auth"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode(
                <String, String>{"email": email, "password": password}))
        .then((response) {
      var body = jsonDecode(handleException(response))["user"];
      userId = body["id"];
      sharedPreferences.setString("userToken", body["token"]);

      return getUserInfos(userId);
    }).then((response) {
      var infos =
          UserInfos.fromJson(jsonDecode(handleException(response))["user"]);
      infos.id = userId;
      sharedPreferences.setString("userInfos", jsonEncode(infos));
      return true;
    }).onError((error, stackTrace) {
      sharedPreferences.remove("userToken");
      return error is AuthenticationException || error is NotFoundException
          ? false
          : Future<bool>.error(error);
    });
  }

  Future<http.Response> register(UserRegisterForm form) {
    return client.post(Uri.parse(Consts.URL_GATEWAY + "/account/register"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(form));
  }

  Future<http.Response> getUserInfos(int userId) {
    return client.get(Uri.parse(Consts.URL_GATEWAY + "/account/user/$userId"),
        headers: <String, String>{"Content-Type": "application/json"});
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey("userToken") &&
        sharedPreferences.containsKey("userInfos");
  }

  UserInfos getUserLoggedInfos() {
    return UserInfos.fromJson(
        jsonDecode(sharedPreferences.getString("userInfos")));
  }

  void logout() {
    sharedPreferences.remove("userToken");
    sharedPreferences.remove("userInfos");
  }
}
