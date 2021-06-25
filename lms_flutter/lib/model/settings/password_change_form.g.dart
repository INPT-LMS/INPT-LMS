// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_change_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordEditForm _$PasswordEditFormFromJson(Map<String, dynamic> json) {
  return PasswordEditForm(
    json['oldPassword'] as String,
    json['newPassword'] as String,
  );
}

Map<String, dynamic> _$PasswordEditFormToJson(PasswordEditForm instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
