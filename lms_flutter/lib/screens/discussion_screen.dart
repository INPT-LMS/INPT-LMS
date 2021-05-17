import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms_flutter/model/messages/discussion_data.dart';
import 'package:lms_flutter/model/messages/message_data.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/screens/liste_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/services/data_list/message_list_service.dart';
import 'package:lms_flutter/services/message_service.dart';

import '../services/service_locator.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({Key key}) : super(key: key);

  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  UserInfos infos;
  MessageService messageService;
  TextEditingController messageController;
  @override
  void initState() {
    messageController = TextEditingController();
    messageService = getIt.get<MessageService>();
    infos = UserInfos.fromJson(
        jsonDecode(messageService.sharedPreferences.getString("userInfos")));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var disc = ModalRoute.of(context).settings.arguments as DiscussionData;
    int idDestinataire = infos.id == disc.idParticipant1
        ? disc.idParticipant2
        : disc.idParticipant1;
    return BaseScaffoldAppBar(
      body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListeData(
                    reverse: true,
                    numberPerPage: 10,
                    service:
                        MessageListService(messageService, infos.id, disc.id)),
              ),
              TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                      hintText: "Ecrire un message",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            var texte = messageController.text;
                            if (texte != null && texte.length > 0) {
                              messageService
                                  .envoyerMessage(MessageData(null, null, null,
                                      idDestinataire, null, texte))
                                  .onError((error, stackTrace) => ScaffoldMessenger
                                          .of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                              "Erreur : veuillez reessayer"))));
                              messageController.text = "";
                            }
                          })))
            ],
          )),
    );
  }
}
