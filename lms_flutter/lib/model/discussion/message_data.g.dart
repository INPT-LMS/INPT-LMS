// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) {
  return MessageData(
    json['id'] as String,
    json['idDiscussion'] as String,
    json['idEmetteur'] as int,
    json['idDestinataire'] as int,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['contenu'] as String,
  );
}

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idDiscussion': instance.idDiscussion,
      'idEmetteur': instance.idEmetteur,
      'idDestinataire': instance.idDestinataire,
      'date': instance.date?.toIso8601String(),
      'contenu': instance.contenu,
    };
