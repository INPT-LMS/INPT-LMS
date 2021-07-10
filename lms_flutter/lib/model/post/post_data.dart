import 'package:json_annotation/json_annotation.dart';

import 'commentaire_data.dart';
import 'like_data.dart';

part 'post_data.g.dart';

@JsonSerializable(explicitToJson: true)
class PostData {
  String id;
  int idProprietaire;
  String idCours;
  DateTime datePublication;
  String contenuPublication;
  List<CommentaireData> commentaires;
  List<LikeData> likes;

  PostData(this.id, this.idProprietaire, this.idCours, this.datePublication,
      this.contenuPublication, this.commentaires, this.likes);

  factory PostData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);

  Map<String, dynamic> toJson() => _$PostDataToJson(this);
}
