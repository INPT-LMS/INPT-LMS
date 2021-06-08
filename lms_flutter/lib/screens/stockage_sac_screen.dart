import 'package:flutter/material.dart';
import 'package:lms_flutter/components/stockage/fichier_resume.dart';
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
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
  @override
  Widget build(BuildContext context) {
    var serviceStockage = getIt.get<StockageService>();
    return BaseScaffoldAppBar(
        body: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Center(child: Text("Mon sac")),
        FutureBuilder<Map<String, dynamic>>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var usedSpace = (snapshot.data["usedSpace"] as int).toDouble() /
                    1024 /
                    1024;
                var totalSpace =
                    (snapshot.data["availableSpace"] as int).toDouble() /
                        1024 /
                        1024;
                return Column(children: [
                  Text(
                      "Espace utilisé : ${usedSpace.toStringAsFixed(2)} / ${totalSpace.toStringAsFixed(2)} MB"),
                  Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 20,
                          child: LinearProgressIndicator(
                              value: usedSpace / totalSpace)))
                ]);
              } else
                return Text("Espace utilisé : ");
            },
            future: serviceStockage.getUsedSpace()),
        ChangeNotifierProvider(
            create: (context) => ListDataModel<Fichier>(
                <Fichier>[], <Widget>[], (fichier) => FichierResume(fichier)),
            child: ListeData<Fichier>(
                FichierListService(getIt.get<StockageService>(),
                    Consts.URL_GATEWAY + "/storage/user/files"),
                false,
                shrinkWrap: true))
      ]),
    ));
  }
}
