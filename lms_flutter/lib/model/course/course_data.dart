import 'package:json_annotation/json_annotation.dart';
import 'package:lms_flutter/model/course/visibility_data.dart';

part 'course_data.g.dart';

@JsonSerializable()
class CourseData {
  String courseID;
  String courseName;
  String courseDescription;
  String imageURL;
  Visibility visibility;

  CourseData(this.courseID, this.courseName, this.courseDescription,
      this.imageURL, this.visibility);

  factory CourseData.fromJson(Map<String, dynamic> json) =>
      _$CourseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDataToJson(this);
}
