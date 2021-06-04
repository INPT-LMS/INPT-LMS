import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/model/devoir/devoir_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:provider/provider.dart';

class DevoirDetailsScreen extends StatefulWidget {
  const DevoirDetailsScreen({Key key}) : super(key: key);

  @override
  _DevoirDetailsScreenState createState() => _DevoirDetailsScreenState();
}

//TODO: rendre devoir + afficher les réponses + supprimer le devoir
class _DevoirDetailsScreenState extends State<DevoirDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var infos = Provider.of<InfosModel>(context).userInfos;
    var devoirData = ModalRoute.of(context).settings.arguments as DevoirData;
    var isOwner = infos.id == devoirData.idProprietaire;
    var isFinished = DateTime.now().isAfter(devoirData.dateLimite);

    String texte;
    if (!isOwner) {
      if (devoirData.reponses.isNotEmpty) {
        var reponse = devoirData.reponses[0];
        texte = reponse.estNote && isFinished
            ? "[Devoir rendu : votre note est ${reponse.note}]"
            : "[Devoir rendu]";
      } else
        texte = isFinished ? "[Devoir non rendu]" : "[Devoir pas encore rendu]";
    }

    return BaseScaffoldAppBar(
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
                Row(children: [
                  TextButton(
                      child: Text("Voir les réponses"), onPressed: () {}),
                  TextButton(
                      child: Text("Supprimer le devoir"), onPressed: () {})
                ])
              else if (!isFinished)
                TextButton(child: Text("Rendre le devoir"), onPressed: () {})
            ])));
  }
}
