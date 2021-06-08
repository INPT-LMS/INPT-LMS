import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/screens/utils.dart';

class FichierResume extends StatelessWidget {
  final Fichier fichier;
  FichierResume(this.fichier, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = fichier.fichierInfo.dateCreation;
    return ListTile(
      leading: Icon(findIconFromFileType(fichier.fichierInfo.contentType)),
      title: Text(fichier.fichierInfo.nom),
      subtitle:
          Text("Ajouté le ${DateFormat.yMMMMd('fr_FR').add_Hm().format(date)}"),
      onTap: () {
        Navigator.pushNamed(context, "/fichier-details", arguments: fichier);
      },
    );
  }
}
