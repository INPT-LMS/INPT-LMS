// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fichier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fichier _$FichierFromJson(Map<String, dynamic> json) {
  return Fichier(
    json['id'] as int,
    json['fichierInfo'] == null
        ? null
        : FichierInfo.fromJson(json['fichierInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FichierToJson(Fichier instance) => <String, dynamic>{
      'id': instance.id,
      'fichierInfo': instance.fichierInfo,
    };
