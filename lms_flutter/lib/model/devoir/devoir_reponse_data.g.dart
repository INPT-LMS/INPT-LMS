// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devoir_reponse_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevoirReponseData _$DevoirReponseDataFromJson(Map<String, dynamic> json) {
  return DevoirReponseData(
    json['id'] as String,
    json['idProprietaire'] as int,
    json['note'] as int,
    json['estNote'] as bool,
  );
}

Map<String, dynamic> _$DevoirReponseDataToJson(DevoirReponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idProprietaire': instance.idProprietaire,
      'note': instance.note,
      'estNote': instance.estNote,
    };
