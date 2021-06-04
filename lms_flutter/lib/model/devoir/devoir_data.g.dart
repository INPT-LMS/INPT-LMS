// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devoir_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevoirData _$DevoirDataFromJson(Map<String, dynamic> json) {
  return DevoirData(
    json['id'] as String,
    json['idCours'] as String,
    json['idProprietaire'] as int,
    json['type'] as String,
    json['devoirInfos'] == null
        ? null
        : DevoirInfos.fromJson(json['devoirInfos'] as Map<String, dynamic>),
    (json['reponses'] as List)
        ?.map((e) => e == null
            ? null
            : DevoirReponseData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['dateLimite'] == null
        ? null
        : DateTime.parse(json['dateLimite'] as String),
  );
}

Map<String, dynamic> _$DevoirDataToJson(DevoirData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idCours': instance.idCours,
      'idProprietaire': instance.idProprietaire,
      'type': instance.type,
      'devoirInfos': instance.devoirInfos,
      'reponses': instance.reponses,
      'dateLimite': instance.dateLimite?.toIso8601String(),
    };
