import 'package:json_annotation/json_annotation.dart';

part 'password_change_form.g.dart';

@JsonSerializable()
class PasswordEditForm {
  String oldPassword;
  String newPassword;

  PasswordEditForm(this.oldPassword, this.newPassword);
  factory PasswordEditForm.fromJson(Map<String, dynamic> json) =>
      _$PasswordEditFormFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordEditFormToJson(this);
}
