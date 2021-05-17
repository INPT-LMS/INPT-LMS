import 'package:json_annotation/json_annotation.dart';

part 'user_infos.g.dart';

@JsonSerializable()
class UserInfos {
  int id;
  String nom;
  String email;
  String langue;
  bool estProfesseur;
  String enseigneA;
  String etudieA;

  UserInfos(this.id, this.nom, this.email, this.langue, this.estProfesseur,
      this.enseigneA, this.etudieA);

  factory UserInfos.fromJson(Map<String, dynamic> json) =>
      _$UserInfosFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfosToJson(this);
}
