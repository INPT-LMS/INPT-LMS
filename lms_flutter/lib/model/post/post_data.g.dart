// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostData _$PostDataFromJson(Map<String, dynamic> json) {
  return PostData(
    json['id'] as String,
    json['idProprietaire'] as int,
    json['idCours'] as String,
    json['datePublication'] == null
        ? null
        : DateTime.parse(json['datePublication'] as String),
    json['contenuPublication'] as String,
    (json['commentaires'] as List)
        ?.map((e) => e == null
            ? null
            : CommentaireData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['likes'] as List)
        ?.map((e) =>
            e == null ? null : LikeData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PostDataToJson(PostData instance) => <String, dynamic>{
      'id': instance.id,
      'idProprietaire': instance.idProprietaire,
      'idCours': instance.idCours,
      'datePublication': instance.datePublication?.toIso8601String(),
      'contenuPublication': instance.contenuPublication,
      'commentaires': instance.commentaires,
      'likes': instance.likes,
    };
