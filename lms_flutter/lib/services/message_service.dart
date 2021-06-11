import 'package:dio/dio.dart';
import 'package:lms_flutter/model/discussion/message_data.dart';
import 'package:lms_flutter/model/pagination/pagination_discussion.dart';
import 'package:lms_flutter/model/pagination/pagination_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_service.dart';

/// Service chargé des interactions liées à la messagerie
class MessageService extends BaseService {
  MessageService(SharedPreferences sharedPreferences, Dio client)
      : super(sharedPreferences, client);

  Future<List<String>> getDiscussionHasNewMessage() {
    return client.get("/messagebox/infos/new").then((response) {
      var listDynamic = response.data as List;
      return listDynamic.map<String>((item) => item.toString()).toList();
    });
  }

  Future<PaginationDiscussion> getDiscussions(int size, int page) {
    return client
        .get("/messagebox/infos?page=$page&size=$size&sort=lastUpdate,desc")
        .then((response) => PaginationDiscussion.fromJson(response.data));
  }

  Future<PaginationMessage> getDiscussionMessages(
      String discId, int size, int page) {
    return client
        .get(
            "/messagebox/discussion/$discId?page=$page&size=$size&sort=date,desc")
        .then((response) => PaginationMessage.fromJson(response.data));
  }

  Future<MessageData> envoyerMessage(MessageData message) {
    return client
        .post("/messagebox/discussion", data: message.toJson())
        .then((response) => MessageData.fromJson(response.data));
  }
}
