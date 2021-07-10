// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devoir_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevoirInfos _$DevoirInfosFromJson(Map<String, dynamic> json) {
  return DevoirInfos(
    json['id'] as String,
    json['contenu'] as String,
    json['dateCreation'] == null
        ? null
        : DateTime.parse(json['dateCreation'] as String),
  );
}

Map<String, dynamic> _$DevoirInfosToJson(DevoirInfos instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contenu': instance.contenu,
      'dateCreation': instance.dateCreation?.toIso8601String(),
    };
