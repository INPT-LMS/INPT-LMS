import 'dart:convert';

import 'package:lms_flutter/model/discussions/message_data.dart';

class PaginationMessage {
  bool last;
  List<MessageData> content;

  PaginationMessage(this.last, this.content);

  PaginationMessage.fromJson(Map<String, dynamic> json) {
    last = json["last"] as bool;
    content = (json["content"] as List)
        .map<MessageData>((json) => MessageData.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "last": jsonEncode(last),
        "content": jsonEncode(content)
      };
}
