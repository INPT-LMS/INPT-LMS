import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms_flutter/components/discussions/message.dart';
import 'package:lms_flutter/model/discussions/discussion_data.dart';
import 'package:lms_flutter/model/discussions/message_data.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/screens/liste/liste_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:lms_flutter/services/data_list/message_list_service.dart';
import 'package:lms_flutter/services/message_service.dart';
import 'package:provider/provider.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    infos = Provider.of<InfosModel>(context).userInfos;
    var disc = ModalRoute.of(context).settings.arguments as DiscussionData;
    int idDestinataire = infos.id == disc.idParticipant1
        ? disc.idParticipant2
        : disc.idParticipant1;
    var messageListService =
        MessageListService(messageService, infos.id, disc.id);

    return BaseScaffoldAppBar(
        body: Container(
            margin: EdgeInsets.all(10),
            child: ChangeNotifierProvider<ListDataModel<MessageData>>(
                create: (context) => ListDataModel<MessageData>(<MessageData>[],
                    <Widget>[], (messageData) => Message(messageData)),
                builder: (context, _) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListeData<MessageData>(
                          messageListService,
                          true,
                        ),
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
                                      var messageToSend = MessageData(
                                          null,
                                          disc.id,
                                          infos.id,
                                          idDestinataire,
                                          DateTime.now(),
                                          texte);
                                      messageService
                                          .envoyerMessage(messageToSend)
                                          .then((value) {
                                        Provider.of<ListDataModel<MessageData>>(
                                                context,
                                                listen: false)
                                            .addFirst(messageToSend);
                                      }, onError: (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Erreur : veuillez reessayer")));
                                      });
                                      messageController.text = "";
                                    }
                                  })))
                    ],
                  );
                })));
  }
}
