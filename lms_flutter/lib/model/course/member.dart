import 'package:json_annotation/json_annotation.dart';
import 'package:lms_flutter/model/course/course_data.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  int memberID;
  List<CourseData> courses;

  Member(this.memberID, this.courses);

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
