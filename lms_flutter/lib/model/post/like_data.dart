import 'package:json_annotation/json_annotation.dart';

part 'like_data.g.dart';

@JsonSerializable()
class LikeData{
  String id;
  String idPublication;
  DateTime dateLike;
  int idProprietaire;

  LikeData(this.id, this.idPublication, this.dateLike, this.idProprietaire);

  factory LikeData.fromJson(Map<String, dynamic> json) =>
      _$LikeDataFromJson(json);

  Map<String, dynamic> toJson() => _$LikeDataToJson(this);
}