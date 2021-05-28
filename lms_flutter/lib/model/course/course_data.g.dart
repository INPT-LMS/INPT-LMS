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
  );
}

Map<String, dynamic> _$CourseDataToJson(CourseData instance) =>
    <String, dynamic>{
      'courseID': instance.courseID,
      'courseName': instance.courseName,
      'courseDescription': instance.courseDescription,
      'imageURL': instance.imageURL,
      'visibility': instance.visibility,
    };
