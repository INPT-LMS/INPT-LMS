import 'dart:convert';

import 'package:lms_flutter/model/stockage/fichier.dart';

class PaginationFichier {
  bool last;
  List<Fichier> content;

  PaginationFichier(this.last, this.content);

  PaginationFichier.fromJson(Map<String, dynamic> json) {
    last = json["last"] as bool;
    content = (json["content"] as List)
        .map<Fichier>((json) => Fichier.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "last": jsonEncode(last),
        "content": jsonEncode(content)
      };
}
