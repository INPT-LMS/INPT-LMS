import 'package:json_annotation/json_annotation.dart';

part 'devoir_infos.g.dart';

@JsonSerializable()
class DevoirInfos {
  String id;
  String contenu;
  DateTime dateCreation;

  DevoirInfos(this.id, this.contenu, this.dateCreation);

  factory DevoirInfos.fromJson(Map<String, dynamic> json) =>
      _$DevoirInfosFromJson(json);

  Map<String, dynamic> toJson() => _$DevoirInfosToJson(this);
}
