import 'dart:convert';

import 'package:lms_flutter/model/posts/post_data.dart';

class PaginationPost {
  bool last;
  List<PostData> content;

  PaginationPost(this.last, this.content);

  PaginationPost.fromJson(Map<String, dynamic> json) {
    last = json["last"] as bool;
    content = (json["content"] as List)
        .map<PostData>((json) => PostData.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "last": jsonEncode(last),
    "content": jsonEncode(content)
  };
}
