import 'package:json_annotation/json_annotation.dart';
import 'package:lms_flutter/model/messages/message_data.dart';

part 'discussion_data.g.dart';

@JsonSerializable()
class DiscussionData {
  String id;
  String nomParticipant1;
  int idParticipant1;
  String nomParticipant2;
  int idParticipant2;
  MessageData lastMessage;
  DateTime lastUpdate;

  DiscussionData(
      this.id,
      this.nomParticipant1,
      this.idParticipant1,
      this.nomParticipant2,
      this.idParticipant2,
      this.lastMessage,
      this.lastUpdate);

  factory DiscussionData.fromJson(Map<String, dynamic> json) =>
      _$DiscussionDataFromJson(json);

  Map<String, dynamic> toJson() => _$DiscussionDataToJson(this);
}
