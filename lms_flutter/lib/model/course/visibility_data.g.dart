// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visibility_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visibility _$VisibilityFromJson(Map<String, dynamic> json) {
  return Visibility(
    json['visibilityID'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$VisibilityToJson(Visibility instance) =>
    <String, dynamic>{
      'visibilityID': instance.visibilityID,
      'name': instance.name,
    };
