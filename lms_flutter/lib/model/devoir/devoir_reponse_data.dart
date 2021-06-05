import 'package:json_annotation/json_annotation.dart';

part 'devoir_reponse_data.g.dart';

@JsonSerializable()
class DevoirReponseData {
  String id;
  int idProprietaire;
  int note;
  DateTime dateRendu;
  bool estNote;

  DevoirReponseData(this.id, this.idProprietaire, this.note, this.estNote);

  factory DevoirReponseData.fromJson(Map<String, dynamic> json) =>
      _$DevoirReponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DevoirReponseDataToJson(this);
}
