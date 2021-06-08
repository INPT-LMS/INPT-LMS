import 'package:json_annotation/json_annotation.dart';

part 'fichier_info.g.dart';

@JsonSerializable()
class FichierInfo {
  DateTime dateCreation;
  String nom;
  int size;
  String contentType;

  FichierInfo(this.dateCreation, this.nom, this.size, this.contentType);

  factory FichierInfo.fromJson(Map<String, dynamic> json) =>
      _$FichierInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FichierInfoToJson(this);
}
