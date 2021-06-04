import 'package:json_annotation/json_annotation.dart';

part 'message_data.g.dart';

@JsonSerializable()
class MessageData {
  String id;
  String idDiscussion;
  int idEmetteur;
  int idDestinataire;
  DateTime date;
  String contenu;

  MessageData(this.id, this.idDiscussion, this.idEmetteur, this.idDestinataire,
      this.date, this.contenu);

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}
