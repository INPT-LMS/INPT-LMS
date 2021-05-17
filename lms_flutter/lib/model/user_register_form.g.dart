// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegisterForm _$UserRegisterFormFromJson(Map<String, dynamic> json) {
  return UserRegisterForm(
    json['email'] as String,
    json['password'] as String,
    json['nom'] as String,
    json['prenom'] as String,
    json['estProfesseur'] as bool,
  );
}

Map<String, dynamic> _$UserRegisterFormToJson(UserRegisterForm instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'estProfesseur': instance.estProfesseur,
    };
