import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/discussion/message_data.dart';
import 'package:lms_flutter/model/pagination/pagination_discussion.dart';
import 'package:lms_flutter/model/pagination/pagination_message.dart';
import 'package:lms_flutter/services/exceptions/network_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_service.dart';

/// Service chargé des interactions liées à la messagerie
class MessageService extends BaseService {
  MessageService(SharedPreferences sharedPreferences, http.Client client)
      : super(sharedPreferences, client);

  Future<List<String>> getDiscussionHasNewMessage() {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/messagebox/infos/new");

    return client
        .get(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) {
      var listDynamic = jsonDecode(handleException(response)) as List;
      return listDynamic.map<String>((item) => item.toString()).toList();
    });
  }

  Future<PaginationDiscussion> getDiscussions(int size, int page) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY +
        "/messagebox/infos?page=$page&size=$size&sort=lastUpdate,desc");
    return client.get(url, headers: headers).timeout(
        Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) =>
        PaginationDiscussion.fromJson(jsonDecode(handleException(response))));
  }

  Future<PaginationMessage> getDiscussionMessages(
      String discId, int size, int page) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY +
        "/messagebox/discussion/$discId?page=$page&size=$size&sort=date,desc");
    return client
        .get(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) =>
            PaginationMessage.fromJson(jsonDecode(handleException(response))));
  }

  Future<MessageData> envoyerMessage(MessageData message) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/messagebox/discussion");
    return client
        .post(url, body: jsonEncode(message), headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) =>
            MessageData.fromJson(jsonDecode(handleException(response))));
  }
}
