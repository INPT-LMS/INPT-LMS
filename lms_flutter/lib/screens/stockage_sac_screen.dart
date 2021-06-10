import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/stockage/fichier_resume.dart';
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:lms_flutter/services/data_list/fichier_list_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/services/stockage_service.dart';
import 'package:provider/provider.dart';

import 'liste/liste_data.dart';

class StockageSacScreen extends StatefulWidget {
  const StockageSacScreen({Key key}) : super(key: key);

  @override
  _StockageSacScreenState createState() => _StockageSacScreenState();
}

class _StockageSacScreenState extends State<StockageSacScreen> {
  StockageService stockageService;
  double usedSpace;
  double totalSpace;
  @override
  void initState() {
    super.initState();
    stockageService = getIt.get<StockageService>();
    usedSpace = 0.0;
    totalSpace = 1048576.0;
    stockageService.getUsedSpace().then((value) {
      setState(() {
        usedSpace = (value["usedSpace"] as int).toDouble();
        totalSpace = (value["availableSpace"] as int).toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
        body: SingleChildScrollView(
            child: ChangeNotifierProvider(
      create: (context) => ListDataModel<Fichier>(
          (fichier) => FichierResume(
                fichier,
                onDelete: (fichier) => updateSize(-fichier.fichierInfo.size),
              ),
          (fichier) => fichier.id),
      builder: (context, _) {
        var usedSpaceMB = usedSpace / 1024 / 1024;
        var totalSpaceMB = totalSpace / 1024 / 1024;
        return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Center(child: Text("Mon sac")),
          Text(
              "Espace utilisé : ${usedSpaceMB.toStringAsFixed(2)} / ${totalSpaceMB.toStringAsFixed(2)} MB"),
          Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 20,
                  child: LinearProgressIndicator(
                      value: usedSpaceMB / totalSpaceMB))),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Center(
                  child: ElevatedButton(
                      child: Text("Ajouter un fichier"),
                      onPressed: () => uploadFichier(context)))),
          ListeData<Fichier>(
              FichierListService(getIt.get<StockageService>(),
                  Consts.URL_GATEWAY + "/storage/user/files"),
              false,
              shrinkWrap: true)
        ]);
      },
    )));
  }

  void uploadFichier(context) {
    FilePicker.platform
        .pickFiles(allowMultiple: false, withReadStream: true)
        .then((result) {
      if (result.isSinglePick)
        stockageService
            .uploadFichier(
                Consts.URL_GATEWAY + "/storage/user/upload", result.files[0])
            .then((fichier) {
          updateSize(fichier.fichierInfo.size);
          Provider.of<ListDataModel<Fichier>>(context, listen: false)
              .addFirst(fichier);
          showSnackbar(context, "Fichier enregistrée dans le sac !");
        }).catchError((e) => showSnackbar(context, "Une erreur est survenue"));
    });
  }

  void updateSize(int sizeToAdd) {
    setState(() {
      usedSpace += sizeToAdd;
      if (usedSpace < 0)
        usedSpace = 0;
      else if (usedSpace > totalSpace) usedSpace = totalSpace;
    });
  }
}
