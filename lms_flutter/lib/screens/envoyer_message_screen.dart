import 'package:flutter/material.dart';
import 'package:lms_flutter/model/discussion/discussion_data.dart';
import 'package:lms_flutter/model/discussion/message_data.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/message_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class EnvoyerMessageScreen extends StatefulWidget {
  final UserInfos userToSend;
  EnvoyerMessageScreen({Key key, this.userToSend}) : super(key: key);

  @override
  _EnvoyerMessageScreenState createState() => _EnvoyerMessageScreenState();
}

class _EnvoyerMessageScreenState extends State<EnvoyerMessageScreen> {
  TextEditingController username;
  TextEditingController content;
  UserInfos selectedUser;
  CompteService compteService;
  MessageService messageService;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    content = TextEditingController();
    compteService = getIt.get<CompteService>();
    messageService = getIt.get<MessageService>();
  }

  @override
  void dispose() {
    username.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var nom;
    if (widget.userToSend != null)
      nom = widget.userToSend.nom + " " + widget.userToSend.prenom;
    else if (selectedUser != null)
      nom = selectedUser.nom + " " + selectedUser.prenom;
    return BaseScaffoldAppBar(
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: Column(children: [
                  if (widget.userToSend == null)
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                                controller: username,
                                validator: (_) => widget.userToSend == null &&
                                        selectedUser == null
                                    ? "Aucun destinataire selectionné"
                                    : null,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        "Nom du destinataire à rerchecher")),
                          ),
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                if (username.text.isNotEmpty)
                                  searchUsers(username.text);
                              })
                        ]),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(nom != null
                          ? "Destinataire : $nom"
                          : "Pas de destinataire choisi")),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: content,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      validator: (value) => value.isEmpty
                          ? "Le message ne peut pas être vide"
                          : null,
                      decoration: InputDecoration(
                        labelText: "Message à envoyer",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      child: Text("Envoyer le message"),
                      onPressed: () {
                        if (formKey.currentState != null &&
                            formKey.currentState.validate()) envoyerMessage();
                      })
                ]))),
      ),
    );
  }

  void searchUsers(String text) {
    compteService.searchUsers(username.text).then((listeUsers) {
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            List<Widget> listeBody;
            if (listeUsers.isEmpty)
              listeBody = <Widget>[Center(child: Text("Pas de résultats"))];
            else
              listeBody = listeUsers
                  .map<Widget>((user) => ListTile(
                        title: Text(user.nom + " " + user.prenom),
                        onTap: () {
                          Navigator.pop(dialogContext, user);
                        },
                      ))
                  .toList();
            return Dialog(child: ListView(children: listeBody));
          }).then((value) {
        if (value == null) return;
        setState(() {
          selectedUser = value;
        });
      });
    });
  }

  void envoyerMessage() {
    var user = widget.userToSend != null ? widget.userToSend : selectedUser;
    messageService
        .envoyerMessage(
            MessageData(null, null, null, user.id, null, content.text))
        .then((message) {
      var data = DiscussionData(message.idDiscussion, null,
          message.idDestinataire, null, message.idEmetteur, null, null);
      Navigator.pushNamed(context, "/discussion", arguments: data);
    }).catchError((error) {
      if (error.response.statusCode == 400)
        showSnackbar(
            context,
            "Impossible d'envoyer un message à cet utilisateur : "
            "il est invalide ou n'existe pas");
      else
        showDefaultErrorMessage(context, error.response.statusCode);
    });
  }
}
