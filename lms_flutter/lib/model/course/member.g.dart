// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    json['memberID'] as int,
    (json['courses'] as List)
        ?.map((e) =>
            e == null ? null : CourseData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'memberID': instance.memberID,
      'courses': instance.courses,
    };
