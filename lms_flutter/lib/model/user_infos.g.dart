// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfos _$UserInfosFromJson(Map<String, dynamic> json) {
  return UserInfos(
    json['id'] as int,
    json['nom'] as String,
    json['prenom'] as String,
    json['email'] as String,
    json['langue'] as String,
    json['estProfesseur'] as bool,
    json['enseigneA'] as String,
    json['etudieA'] as String,
  );
}

Map<String, dynamic> _$UserInfosToJson(UserInfos instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'email': instance.email,
      'langue': instance.langue,
      'estProfesseur': instance.estProfesseur,
      'enseigneA': instance.enseigneA,
      'etudieA': instance.etudieA,
    };
