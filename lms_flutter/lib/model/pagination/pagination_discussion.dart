import 'dart:convert';

import 'package:lms_flutter/model/discussion/discussion_data.dart';

class PaginationDiscussion {
  bool last;
  List<DiscussionData> content;

  PaginationDiscussion(this.last, this.content);

  PaginationDiscussion.fromJson(Map<String, dynamic> json) {
    last = json["last"] as bool;
    content = (json["content"] as List)
        .map<DiscussionData>((json) => DiscussionData.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "last": jsonEncode(last),
        "content": jsonEncode(content)
      };
}
