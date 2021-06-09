import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:provider/provider.dart';

class FichierResume extends StatelessWidget {
  final Fichier fichier;
  final void Function(Fichier fichier) onDelete;
  FichierResume(this.fichier, {Key key, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = fichier.fichierInfo.dateCreation;
    return ListTile(
      leading: Icon(findIconFromFileType(fichier.fichierInfo.contentType)),
      title: Text(fichier.fichierInfo.nom),
      subtitle:
          Text("Ajouté le ${DateFormat.yMMMMd('fr_FR').add_Hm().format(date)}"),
      onTap: () {
        Navigator.pushNamed(context, "/fichier-details", arguments: fichier)
            .then((value) {
          if (value == null) return;
          Provider.of<ListDataModel<Fichier>>(context, listen: false)
              .deleteWhere((item) => item.id == fichier.id);
          if (onDelete != null) this.onDelete(fichier);
        });
      },
    );
  }
}
