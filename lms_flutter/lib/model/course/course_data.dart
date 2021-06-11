import 'package:json_annotation/json_annotation.dart';
import 'package:lms_flutter/model/course/professor.dart';
import 'package:lms_flutter/model/course/visibility_data.dart';

import 'member.dart';

part 'course_data.g.dart';

@JsonSerializable(explicitToJson: true)
class CourseData {
  String courseID;
  String courseName;
  String courseDescription;
  String imageURL;
  Visibility visibility;
  Professor owner;
  List<Member> students;

  CourseData(this.courseID, this.courseName, this.courseDescription,
      this.imageURL, this.visibility);

  factory CourseData.fromJson(Map<String, dynamic> json) =>
      _$CourseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDataToJson(this);
}
