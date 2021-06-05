// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Professor _$ProfessorFromJson(Map<String, dynamic> json) {
  return Professor(
    json['professorID'] as int,
    (json['ownedCourses'] as List)
        ?.map((e) =>
            e == null ? null : CourseData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProfessorToJson(Professor instance) => <String, dynamic>{
      'professorID': instance.professorID,
      'ownedCourses': instance.ownedCourses,
    };
