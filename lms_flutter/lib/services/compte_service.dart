import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/model/user_register_form.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Service chargé de la connexion et de l'inscription <br />
///Il gère les tokens et les informations utilisateur
class CompteService extends BaseService {
  CompteService(SharedPreferences sharedPreferences, Dio client)
      : super(sharedPreferences, client);

  Future<bool> login(String email, String password) {
    int userId;
    return client.post("/account/auth",
        data: {"email": email, "password": password}).then((response) {
      var body = response.data["user"];
      userId = body["id"];
      sharedPreferences.setString("userToken", body["token"]);

      return getUserInfos(userId);
    }).then((infos) {
      infos.id = userId;
      sharedPreferences.setString("userInfos", jsonEncode(infos));
      return true;
    }).onError((error, _) {
      sharedPreferences.remove("userToken");
      if (error.type != DioErrorType.response) return Future.error(error);
      var statusCode = (error as DioError).response.statusCode;
      return (statusCode == 401 || statusCode == 404)
          ? false
          : Future.error(error);
    });
  }

  Future register(UserRegisterForm form) {
    return client.post("/account/register", data: form.toJson());
  }

  Future<UserInfos> getUserInfos(int userId) {
    return client
        .get("/account/user/$userId")
        .then((response) => UserInfos.fromJson(response.data["user"]));
  }

  Future<List<UserInfos>> searchUsers(String name) {
    return client.get("/account/search", queryParameters: <String, String>{
      "name": name
    }).then((response) => (response.data as List)
        .map<UserInfos>((userJson) => UserInfos.fromJson(userJson["userInfos"]))
        .toList());
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey("userToken") &&
        sharedPreferences.containsKey("userInfos");
  }

  UserInfos getUserLoggedInfos() {
    return UserInfos.fromJson(
        jsonDecode(sharedPreferences.getString("userInfos")));
  }

  String getUserToken() {
    return sharedPreferences.getString("userToken");
  }

  void logout() {
    sharedPreferences.remove("userToken");
    sharedPreferences.remove("userInfos");
  }
}
