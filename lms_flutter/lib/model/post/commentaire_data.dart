import 'package:json_annotation/json_annotation.dart';

part 'commentaire_data.g.dart';

@JsonSerializable()
class CommentaireData {
  String id;
  String idPublication;
  DateTime dateCommentaire;
  String contenuCommentaire;
  int idProprietaire;

  CommentaireData(this.id, this.idPublication, this.dateCommentaire,
      this.contenuCommentaire, this.idProprietaire);

  factory CommentaireData.fromJson(Map<String, dynamic> json) =>
      _$CommentaireDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommentaireDataToJson(this);
}
