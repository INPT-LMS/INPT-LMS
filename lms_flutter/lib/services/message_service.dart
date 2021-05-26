import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/consts/base_url.dart';
import 'package:lms_flutter/model/discussions/message_data.dart';
import 'package:lms_flutter/model/pagination/pagination_discussion.dart';
import 'package:lms_flutter/model/pagination/pagination_message.dart';
import 'package:lms_flutter/services/exceptions/network_exception.dart';
import 'package:lms_flutter/services/exceptions/unknown_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_service.dart';

class MessageService extends BaseService{
  MessageService(SharedPreferences sharedPreferences) : super(sharedPreferences);

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
