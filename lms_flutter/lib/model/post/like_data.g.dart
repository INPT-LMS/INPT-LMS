// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeData _$LikeDataFromJson(Map<String, dynamic> json) {
  return LikeData(
    json['id'] as String,
    json['idPublication'] as String,
    json['dateLike'] == null
        ? null
        : DateTime.parse(json['dateLike'] as String),
    json['idProprietaire'] as int,
  );
}

Map<String, dynamic> _$LikeDataToJson(LikeData instance) => <String, dynamic>{
      'id': instance.id,
      'idPublication': instance.idPublication,
      'dateLike': instance.dateLike?.toIso8601String(),
      'idProprietaire': instance.idProprietaire,
    };
