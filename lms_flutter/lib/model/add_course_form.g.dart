// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_course_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCourseForm _$AddCourseFormFromJson(Map<String, dynamic> json) {
  return AddCourseForm(
    json['courseName'] as String,
    json['courseDescription'] as String,
    json['imageURL'] as String,
  );
}

Map<String, dynamic> _$AddCourseFormToJson(AddCourseForm instance) =>
    <String, dynamic>{
      'courseName': instance.courseName,
      'courseDescription': instance.courseDescription,
      'imageURL': instance.imageURL,
    };
