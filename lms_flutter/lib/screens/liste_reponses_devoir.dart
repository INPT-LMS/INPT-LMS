import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/devoir/devoir_data.dart';
import 'package:lms_flutter/model/devoir/devoir_reponse_data.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/devoir_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/services/stockage_service.dart';

class ListeReponsesDevoirScreen extends StatefulWidget {
  const ListeReponsesDevoirScreen({Key key}) : super(key: key);

  @override
  _ListeReponsesDevoirScreenState createState() =>
      _ListeReponsesDevoirScreenState();
}

class _ListeReponsesDevoirScreenState extends State<ListeReponsesDevoirScreen> {
  CompteService compteService;
  StockageService stockageService;
  DevoirService devoirService;
  TextEditingController noteController;
  DevoirData devoirData;

  @override
  void initState() {
    super.initState();
    compteService = getIt.get<CompteService>();
    stockageService = getIt.get<StockageService>();
    devoirService = getIt.get<DevoirService>();
    noteController = TextEditingController();
    _setupListener();
  }

  @override
  void dispose() {
    _removeListener();
    noteController.dispose();
    super.dispose();
  }

  FutureBuilder<UserInfos> buildTile(
      DevoirReponseData reponse, String baseUrl) {
    return FutureBuilder<UserInfos>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) return ListTile();
        var eleveInfos = snapshot.data;
        var fullname = "${eleveInfos.nom} ${eleveInfos.prenom}";
        var formKey = GlobalKey<FormState>();
        return Column(children: [
          ListTile(
              title: Text("Devoir de $fullname"),
              subtitle: Text(
                reponse.estNote
                    ? "Devoir noté : ${reponse.note}/20"
                    : "Devoir pas encore noté",
                style: TextStyle(
                    color: reponse.estNote
                        ? Colors.greenAccent
                        : Colors.lightBlueAccent),
              )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () {
                  stockageService.downloadFichier(
                      "$baseUrl/${reponse.idProprietaire}",
                      reponse.fichier.nom);
                },
                child: Text("Voir sa réponse")),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        if (reponse.estNote)
                          noteController.text = "${reponse.note}";
                        return Dialog(
                            child: Container(
                          margin: EdgeInsets.all(20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Form(
                                    key: formKey,
                                    child: Expanded(
                                      child: TextFormField(
                                          controller: noteController,
                                          keyboardType: TextInputType.number,
                                          validator: (nombre) {
                                            if (int.tryParse(nombre) == null)
                                              return "La note doit être un nombre";
                                            var note = int.parse(nombre);
                                            if (note < 0 || note > 20)
                                              return "La note doit être 0 et 20";
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              labelText: "Note sur 20")),
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState == null ||
                                          !formKey.currentState.validate())
                                        return;
                                      var note = int.parse(noteController.text);
                                      devoirService
                                          .noterDevoir(devoirData.idCours,
                                              devoirData.id, reponse.id, note)
                                          .then((_) {
                                        Navigator.pop(context);
                                        setState(() {
                                          reponse.estNote = true;
                                          reponse.note = note;
                                        });
                                      }).catchError((_) {
                                        showSnackbar(context,
                                            "Une erreur s'est produite");
                                      });
                                    },
                                    child: Text("Noter"))
                              ]),
                        ));
                      });
                },
                child: Text("Noter sa réponse"))
          ])
        ]);
      },
      future: compteService.getUserInfos(reponse.idProprietaire),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (devoirData == null)
      devoirData = ModalRoute.of(context).settings.arguments as DevoirData;
    var reponses = devoirData.reponses;
    var baseUrl = Consts.URL_GATEWAY +
        "/storage/assignment/${devoirData.idCours}/${devoirData.id}/response";
    var listeWidgets =
        reponses.map<Widget>((reponse) => buildTile(reponse, baseUrl)).toList();
    return BaseScaffoldAppBar(
        beforePush: _removeListener,
        afterReturn: _setupListener,
        body: Container(
            margin: EdgeInsets.all(20),
            child: ListView(
              children: listeWidgets,
            )));
  }

  ReceivePort _port = ReceivePort();

  void _setupListener() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  void _removeListener() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
}
