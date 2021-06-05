import 'package:json_annotation/json_annotation.dart';

import 'course_data.dart';

part 'professor.g.dart';

@JsonSerializable()
class Professor {
  int professorID;
  List<CourseData> ownedCourses;

  Professor(this.professorID, this.ownedCourses);

  factory Professor.fromJson(Map<String, dynamic> json) =>
      _$ProfessorFromJson(json);

  Map<String, dynamic> toJson() => _$ProfessorToJson(this);
}
