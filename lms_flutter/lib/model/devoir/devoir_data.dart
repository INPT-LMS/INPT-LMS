import 'package:json_annotation/json_annotation.dart';

import 'devoir_infos.dart';
import 'devoir_reponse_data.dart';

part 'devoir_data.g.dart';

@JsonSerializable()
class DevoirData {
  String id;
  String idCours;
  int idProprietaire;
  String type;
  DevoirInfos devoirInfos;
  List<DevoirReponseData> reponses;
  DateTime dateLimite;

  DevoirData(this.id, this.idCours, this.idProprietaire, this.type,
      this.devoirInfos, this.reponses, this.dateLimite);

  factory DevoirData.fromJson(Map<String, dynamic> json) =>
      _$DevoirDataFromJson(json);

  Map<String, dynamic> toJson() => _$DevoirDataToJson(this);
}
