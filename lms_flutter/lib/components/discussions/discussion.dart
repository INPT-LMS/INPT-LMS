import 'package:flutter/material.dart';
import 'package:lms_flutter/model/discussion/discussion_data.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:provider/provider.dart';

class Discussion extends StatelessWidget {
  DiscussionData data;
  Discussion(
    this.data, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var infos = Provider.of<InfosModel>(context, listen: false).userInfos;
    return ListTile(
      title: Text(data.idParticipant1 == infos.id
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
