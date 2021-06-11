import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms_flutter/components/discussions/message.dart';
import 'package:lms_flutter/model/discussion/discussion_data.dart';
import 'package:lms_flutter/model/discussion/message_data.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/screens/liste/liste_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
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
  ConnectivityResult network;
  MessageService messageService;
  TextEditingController messageController;
  int idDestinataire;
  String idDiscussion;
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
    var infosModele = Provider.of<InfosModel>(context);
    infos = infosModele.userInfos;
    network = infosModele.networkType;
    var disc = ModalRoute.of(context).settings.arguments as DiscussionData;
    idDestinataire = infos.id == disc.idParticipant1
        ? disc.idParticipant2
        : disc.idParticipant1;
    idDiscussion = disc.id;
    var messageListService =
        MessageListService(messageService, infos.id, disc.id);

    return BaseScaffoldAppBar(
        body: Container(
            margin: EdgeInsets.all(10),
            child: ChangeNotifierProvider<ListDataModel<MessageData>>(
                create: (context) => ListDataModel<MessageData>(
                    (messageData) => Message(messageData),
                    (messageData) => messageData.id),
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
                                    envoyerMessage(context);
                                  })))
                    ],
                  );
                })));
  }

  envoyerMessage(BuildContext context) {
    var texte = messageController.text;
    if (texte == null || texte.length == 0)
      return;
    else if (network == ConnectivityResult.none) {
      showSnackbar(context, "Pas de connexion");
      return;
    }
    var messageToSend =
        MessageData(null, idDiscussion, infos.id, idDestinataire, null, texte);
    messageService.envoyerMessage(messageToSend).then((message) {
      Provider.of<ListDataModel<MessageData>>(context, listen: false)
          .addFirst(message);
    }).catchError((error) {
      if (error.response.status == 400)
        showSnackbar(
            context,
            "Impossible d'envoyer un message à cet utilisateur : "
            "il est invalide ou n'existe pas");
      else
        showDefaultErrorMessage(context, error.response.statusCode);
    });
    messageController.clear();
  }
}
