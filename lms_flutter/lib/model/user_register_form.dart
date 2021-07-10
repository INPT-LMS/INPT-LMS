import 'package:json_annotation/json_annotation.dart';

part 'user_register_form.g.dart';

@JsonSerializable()
class UserRegisterForm {
  String email;
  String password;
  String nom;
  String prenom;
  bool estProfesseur;
  String etudieA;
  String enseigneA;

  UserRegisterForm(this.email, this.password, this.nom, this.prenom,
      this.estProfesseur, this.etudieA, this.enseigneA);

  factory UserRegisterForm.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterFormFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterFormToJson(this);
}
