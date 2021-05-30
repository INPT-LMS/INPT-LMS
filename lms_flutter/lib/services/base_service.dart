import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'exceptions/authentication_exception.dart';
import 'exceptions/bad_request_exception.dart';
import 'exceptions/not_found_exception.dart';
import 'exceptions/unknown_exception.dart';

abstract class BaseService {
  SharedPreferences sharedPreferences;
  String token;
  Map<String, String> headers;
  http.Client client;

  BaseService(this.sharedPreferences, this.client);

  void loadToken() {
    if (token != null) {
      return;
    } else if (!sharedPreferences.containsKey("userToken")) {
      throw new AuthenticationException();
    } else {
      token = sharedPreferences.getString("userToken");
      headers = <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $token"
      };
    }
  }

  String handleException(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return utf8.decode(response.bodyBytes);
        break;
      case 400:
        throw BadRequestException();
        break;
      case 401:
        throw AuthenticationException();
        break;
      case 404:
        throw NotFoundException();
        break;
      default:
        throw UnknownException();
    }
  }
}
