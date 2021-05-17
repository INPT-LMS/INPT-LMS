// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discussion_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscussionData _$DiscussionDataFromJson(Map<String, dynamic> json) {
  return DiscussionData(
    json['id'] as String,
    json['nomParticipant1'] as String,
    json['idParticipant1'] as int,
    json['nomParticipant2'] as String,
    json['idParticipant2'] as int,
    json['lastMessage'] == null
        ? null
        : MessageData.fromJson(json['lastMessage'] as Map<String, dynamic>),
    json['lastUpdate'] == null
        ? null
        : DateTime.parse(json['lastUpdate'] as String),
  );
}

Map<String, dynamic> _$DiscussionDataToJson(DiscussionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nomParticipant1': instance.nomParticipant1,
      'idParticipant1': instance.idParticipant1,
      'nomParticipant2': instance.nomParticipant2,
      'idParticipant2': instance.idParticipant2,
      'lastMessage': instance.lastMessage,
      'lastUpdate': instance.lastUpdate?.toIso8601String(),
    };
