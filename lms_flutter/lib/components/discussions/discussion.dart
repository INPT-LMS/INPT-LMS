import 'package:flutter/material.dart';
import 'package:lms_flutter/model/messages/discussion_data.dart';

class Discussion extends StatelessWidget {
  DiscussionData data;
  int userId;
  Discussion(
    this.data,
    this.userId, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.idParticipant1 == userId
          ? data.nomParticipant2
          : data.nomParticipant1),
      subtitle: Text(
        data.lastMessage.contenu,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/discussion", ModalRoute.withName("/home"),
            arguments: data);
      },
    );
  }
}
