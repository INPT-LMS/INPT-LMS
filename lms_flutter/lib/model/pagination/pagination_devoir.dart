import 'dart:convert';

import 'package:lms_flutter/model/devoir/devoir_data.dart';

class PaginationDevoir {
  bool last;
  List<DevoirData> content;

  PaginationDevoir(this.last, this.content);

  PaginationDevoir.fromJson(Map<String, dynamic> json) {
    last = json["last"] as bool;
    content = (json["content"] as List)
        .map<DevoirData>((json) => DevoirData.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "last": jsonEncode(last),
        "content": jsonEncode(content)
      };
}
