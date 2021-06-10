import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms_flutter/services/exceptions/forbidden_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exceptions/authentication_exception.dart';
import 'exceptions/bad_request_exception.dart';
import 'exceptions/not_found_exception.dart';
import 'exceptions/unknown_exception.dart';

//TODO: Passage de http vers dio
/// Classe abstraite qui définit un service qui utilise le web <br />
/// Elle définit des méthodes de bases pour la gestion des exceptions
/// et le chargement des headers (content-type, authorization)
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

  String _handleException(
      int statusCode, dynamic input, String Function(dynamic input) converter) {
    switch (statusCode) {
      case 200:
        return converter(input);
        break;
      case 400:
        throw BadRequestException(converter(input));
        break;
      case 401:
        throw AuthenticationException();
        break;
      case 403:
        throw ForbiddenException();
        break;
      case 404:
        throw NotFoundException();
        break;
      default:
        throw UnknownException();
    }
  }

  Future<String> handleExceptionStreamed(http.StreamedResponse response) {
    if (response.statusCode == 200 || response.statusCode == 400)
      return utf8.decodeStream(response.stream).then((body) => Future(() =>
          _handleException(response.statusCode, response, (input) => body)));
    return Future(
        () => _handleException(response.statusCode, response, (input) => ""));
  }

  String handleException(http.Response response) {
    return _handleException(response.statusCode, response,
        (input) => utf8.decode(response.bodyBytes));
  }
}
