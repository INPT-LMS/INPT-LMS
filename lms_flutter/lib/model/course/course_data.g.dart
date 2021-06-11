// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseData _$CourseDataFromJson(Map<String, dynamic> json) {
  return CourseData(
    json['courseID'] as String,
    json['courseName'] as String,
    json['courseDescription'] as String,
    json['imageURL'] as String,
    json['visibility'] == null
        ? null
        : Visibility.fromJson(json['visibility'] as Map<String, dynamic>),
  )
    ..owner = json['owner'] == null
        ? null
        : Professor.fromJson(json['owner'] as Map<String, dynamic>)
    ..students = (json['students'] as List)
        ?.map((e) =>
            e == null ? null : Member.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CourseDataToJson(CourseData instance) =>
    <String, dynamic>{
      'courseID': instance.courseID,
      'courseName': instance.courseName,
      'courseDescription': instance.courseDescription,
      'imageURL': instance.imageURL,
      'visibility': instance.visibility?.toJson(),
      'owner': instance.owner?.toJson(),
      'students': instance.students?.map((e) => e?.toJson())?.toList(),
    };
