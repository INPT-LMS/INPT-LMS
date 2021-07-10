// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fichier_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FichierInfo _$FichierInfoFromJson(Map<String, dynamic> json) {
  return FichierInfo(
    json['dateCreation'] == null
        ? null
        : DateTime.parse(json['dateCreation'] as String),
    json['nom'] as String,
    json['size'] as int,
    json['contentType'] as String,
  );
}

Map<String, dynamic> _$FichierInfoToJson(FichierInfo instance) =>
    <String, dynamic>{
      'dateCreation': instance.dateCreation?.toIso8601String(),
      'nom': instance.nom,
      'size': instance.size,
      'contentType': instance.contentType,
    };
