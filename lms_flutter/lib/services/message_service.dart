import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/consts/base_url.dart';
import 'package:lms_flutter/model/discussions/message_data.dart';
import 'package:lms_flutter/model/pagination/pagination_discussion.dart';
import 'package:lms_flutter/model/pagination/pagination_message.dart';
import 'package:lms_flutter/services/exceptions/authentication_exception.dart';
import 'package:lms_flutter/services/exceptions/network_exception.dart';
import 'package:lms_flutter/services/exceptions/not_found_exception.dart';
import 'package:lms_flutter/services/exceptions/unknown_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageService {
  SharedPreferences sharedPreferences;
  String token;
  Map<String, String> headers;

  MessageService(this.sharedPreferences);

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

  Future<List<String>> getDiscussionHasNewMessage() {
    loadToken();
    Uri url = Uri.parse(BaseUrl.URL_GATEWAY + "/messagebox/infos/new");

    return http.get(url, headers: headers).timeout(Duration(seconds: 5),
        onTimeout: () {
      throw NetworkException();
    }).then(
        (response) => jsonDecode(handleException(response)) as List<String>);
  }

  Future<PaginationDiscussion> getDiscussions(int size, int page) {
    loadToken();
    Uri url = Uri.parse(BaseUrl.URL_GATEWAY +
        "/messagebox/infos?page=$page&size=$size&sort=lastUpdate,desc");
    return http.get(url, headers: headers).timeout(Duration(seconds: 5),
        onTimeout: () {
      throw NetworkException();
    }).then((response) =>
        PaginationDiscussion.fromJson(jsonDecode(handleException(response))));
  }

  Future<PaginationMessage> getDiscussionMessages(
      String discId, int size, int page) {
    loadToken();
    Uri url = Uri.parse(BaseUrl.URL_GATEWAY +
        "/messagebox/discussion/$discId?page=$page&size=$size&sort=date,desc");
    return http.get(url, headers: headers).timeout(Duration(seconds: 5),
        onTimeout: () {
      throw NetworkException();
    }).then((response) =>
        PaginationMessage.fromJson(jsonDecode(handleException(response))));
  }

  Future envoyerMessage(MessageData message) {
    loadToken();
    Uri url = Uri.parse(BaseUrl.URL_GATEWAY + "/messagebox/discussion");
    return http
        .post(url, body: jsonEncode(message), headers: headers)
        .timeout(Duration(seconds: 5), onTimeout: () {
      throw NetworkException();
    }).then((value) {
      if (value.statusCode != 200) throw UnknownException();
    });
  }
}
