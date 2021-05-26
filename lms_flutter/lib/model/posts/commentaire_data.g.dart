// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentaire_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentaireData _$CommentaireDataFromJson(Map<String, dynamic> json) {
  return CommentaireData(
    json['id'] as String,
    json['idPublication'] as String,
    json['dateCommentaire'] == null
        ? null
        : DateTime.parse(json['dateCommentaire'] as String),
    json['contenuCommentaire'] as String,
    json['idProprietaire'] as int,
  );
}

Map<String, dynamic> _$CommentaireDataToJson(CommentaireData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idPublication': instance.idPublication,
      'dateCommentaire': instance.dateCommentaire?.toIso8601String(),
      'contenuCommentaire': instance.contenuCommentaire,
      'idProprietaire': instance.idProprietaire,
    };
