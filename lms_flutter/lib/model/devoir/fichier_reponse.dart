import 'package:json_annotation/json_annotation.dart';

part 'fichier_reponse.g.dart';

@JsonSerializable()
class FichierReponse {
  String id;
  String nom;

  FichierReponse(this.id, this.nom);

  factory FichierReponse.fromJson(Map<String, dynamic> json) =>
      _$FichierReponseFromJson(json);

  Map<String, dynamic> toJson() => _$FichierReponseToJson(this);
}
