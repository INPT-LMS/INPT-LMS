import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/services/stockage_service.dart';

class FichierDetailsScreen extends StatefulWidget {
  const FichierDetailsScreen({Key key}) : super(key: key);

  @override
  _FichierDetailsScreenState createState() => _FichierDetailsScreenState();
}

class _FichierDetailsScreenState extends State<FichierDetailsScreen> {
  StockageService stockageService;
  bool error;
  bool finished;
  @override
  Widget build(BuildContext context) {
    var fichier = ModalRoute.of(context).settings.arguments as Fichier;
    var date = fichier.fichierInfo.dateCreation;
    var tailleMB = (fichier.fichierInfo.size / 1024 / 1024).toStringAsFixed(2);
    if (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
          context, "Une erreur est survenue lors du telechargement"));
      error = false;
    } else if (finished) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => showSnackbar(context, "Téléchargement terminé"));
      finished = false;
    }
    return BaseScaffoldAppBar(
      body: Column(children: [
        Text(fichier.fichierInfo.nom),
        Text("Ajouté le ${DateFormat.yMMMMd('fr_FR').add_Hm().format(date)}"),
        Text("Taille : $tailleMB MB"),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  stockageService.downloadFichier(
                      Consts.URL_GATEWAY + "/storage/user/files/${fichier.id}",
                      fichier.fichierInfo.nom);
                },
                child: Text("Telecharger le fichier"))),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  askConfirmation(context).then((value) {
                    if (value == true)
                      stockageService
                          .deleteFichier("/storage/user/files/${fichier.id}")
                          .then((value) {
                        showSnackbar(context, "Fichier supprimé");
                        Navigator.pop(context, fichier.id);
                      }).catchError((e) {
                        if ((e as DioError).response.statusCode == 400) {
                          showSnackbar(context, "Fichier non trouvé");
                          Navigator.pop(context, fichier.id);
                        } else {
                          showDefaultErrorMessage(
                              context, e.response.statusCode);
                        }
                      });
                  });
                },
                child: Text("Supprimer le fichier"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white))))
      ]),
    );
  }

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      if (status == DownloadTaskStatus.failed) {
        error = true;
      } else if (status == DownloadTaskStatus.complete) {
        finished = true;
      }
      int progress = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);

    stockageService = getIt.get<StockageService>();
    error = false;
    finished = false;
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
}
