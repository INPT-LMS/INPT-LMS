import 'package:json_annotation/json_annotation.dart';

import 'fichier_info.dart';

part 'fichier.g.dart';

@JsonSerializable()
class Fichier {
  int id;
  FichierInfo fichierInfo;

  Fichier(this.id, this.fichierInfo);

  factory Fichier.fromJson(Map<String, dynamic> json) =>
      _$FichierFromJson(json);

  Map<String, dynamic> toJson() => _$FichierToJson(this);
}
