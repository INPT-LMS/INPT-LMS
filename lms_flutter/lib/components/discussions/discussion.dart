import 'package:flutter/material.dart';
import 'package:lms_flutter/components/profile/ProfilePic.dart';
import 'package:lms_flutter/model/discussion/discussion_data.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:provider/provider.dart';

class Discussion extends StatelessWidget {
  final DiscussionData data;
  final bool Function(String discId) hasNewMessages;
  Discussion(
    this.data,
    this.hasNewMessages, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var infos = Provider.of<InfosModel>(context, listen: false).userInfos;
    var hasNew = hasNewMessages(data.id);
    return ListTile(
      leading: ProfilePic(data.idParticipant1 == infos.id
          ? data.idParticipant2
          : data.idParticipant1),
      title: Text(data.idParticipant1 == infos.id
          ? data.nomParticipant2
          : data.nomParticipant1),
      subtitle:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          data.lastMessage.idDestinataire == infos.id
              ? data.lastMessage.contenu
              : "Moi : ${data.lastMessage.contenu}",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: hasNew ? Colors.greenAccent : Colors.black),
        ),
        if (hasNew) Icon(Icons.notifications, color: Colors.greenAccent)
      ]),
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/discussion", ModalRoute.withName("/home"),
            arguments: data);
      },
    );
  }
}
