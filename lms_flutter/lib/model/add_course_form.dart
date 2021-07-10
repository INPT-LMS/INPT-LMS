import 'package:json_annotation/json_annotation.dart';

part 'add_course_form.g.dart';

@JsonSerializable()
class AddCourseForm{
  String courseName;
  String courseDescription;
  String imageURL ;

  AddCourseForm(this.courseName, this.courseDescription, this.imageURL);

  factory AddCourseForm.fromJson(Map<String, dynamic> json) =>
      _$AddCourseFormFromJson(json);

  Map<String, dynamic> toJson() => _$AddCourseFormToJson(this);
}