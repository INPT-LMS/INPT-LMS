import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/devoir/devoir_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/services/devoir_service.dart';
import 'package:lms_flutter/services/exceptions/no_permission_exception.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/services/stockage_service.dart';
import 'package:provider/provider.dart';

class DevoirDetailsScreen extends StatefulWidget {
  const DevoirDetailsScreen({Key key}) : super(key: key);

  @override
  _DevoirDetailsScreenState createState() => _DevoirDetailsScreenState();
}

class _DevoirDetailsScreenState extends State<DevoirDetailsScreen> {
  DevoirService devoirService;
  StockageService stockageService;
  bool downloadError;
  bool finished;

  @override
  Widget build(BuildContext context) {
    var infos = Provider.of<InfosModel>(context).userInfos;
    var devoirData = ModalRoute.of(context).settings.arguments as DevoirData;
    var isOwner = infos.id == devoirData.idProprietaire;
    var isFinished = DateTime.now().isAfter(devoirData.dateLimite);
    var isDone = devoirData.reponses.isNotEmpty;

    String texte;
    if (!isOwner) {
      if (isDone) {
        var reponse = devoirData.reponses[0];
        texte = reponse.estNote && isFinished
            ? "[Devoir rendu : votre note est ${reponse.note}]"
            : "[Devoir rendu]";
      } else
        texte = isFinished ? "[Devoir non rendu]" : "[Devoir pas encore rendu]";
    }

    return BaseScaffoldAppBar(
        beforePush: _removeListener,
        afterReturn: _setupListener,
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(children: [
              Text(
                  "Devoir à rendre avant le "
                  "${DateFormat.yMMMMd('fr_FR').add_Hm().format(devoirData.dateLimite)}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              if (!isOwner) Text(texte),
              Container(margin: EdgeInsets.only(top: 20)),
              Text(devoirData.devoirInfos.contenu),
              if (isOwner)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextButton(
                      child: Text("Voir les réponses"),
                      onPressed: () {
                        Navigator.pushNamed(context, '/liste-reponses-devoir',
                            arguments: devoirData);
                      })
                ])
              else if (!isFinished)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        child: Text(isDone
                            ? "Modifier ma réponse "
                            : "Rendre le devoir"),
                        onPressed: () => uploadFichier(context, isDone)),
                    if (isDone)
                      TextButton(
                        child: Text("Voir ma réponse"),
                        onPressed: () => stockageService.downloadFichier(
                            Consts.URL_GATEWAY +
                                "/storage/assignment/${devoirData.idCours}/${devoirData.id}/response",
                            devoirData.reponses[0].fichier.nom),
                      )
                  ],
                )
            ])));
  }

  void uploadFichier(BuildContext context, bool isDone) {
    var devoirData = ModalRoute.of(context).settings.arguments as DevoirData;
    chooseFile()
        .then((file) =>
            devoirService.rendreDevoir(devoirData.idCours, devoirData.id, file))
        .then((devoirResponse) {
      setState(() {
        devoirData.reponses.add(devoirResponse);
        showSnackbar(
            context,
            isDone
                ? "Votre réponse a bien été modifiée"
                : "Votre réponse a bien été enregistrée");
      });
    }).catchError((error) {
      if (error is NoPermissionException)
        showSnackbar(context, "Vous avez refusé l'acces aux fichiers");
      else if (error is DioError && error.response.statusCode == 413)
        showSnackbar(context, "Ce fichier est trop grand");
      else if (error != "nothing")
        showSnackbar(context, "Une erreur est survenue");
    });
  }

  ReceivePort _port = ReceivePort();

  void _setupListener() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      if (status == DownloadTaskStatus.failed) {
        downloadError = true;
      } else if (status == DownloadTaskStatus.complete) {
        finished = true;
      }
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  void _removeListener() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  void initState() {
    super.initState();
    devoirService = getIt.get<DevoirService>();
    stockageService = getIt.get<StockageService>();
    downloadError = false;
    finished = false;
    _setupListener();
  }

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
}
