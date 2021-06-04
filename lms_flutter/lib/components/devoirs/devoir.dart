import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/model/devoir/devoir_data.dart';

class Devoir extends StatelessWidget {
  DevoirData devoirData;
  int idUser;
  Devoir(this.devoirData, this.idUser, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    String texte = "";
    if (devoirData.idProprietaire == this.idUser)
      color = Colors.black;
    else if (devoirData.reponses.isNotEmpty) {
      color = Colors.green;
      texte = " [RENDU]";
    } else {
      var isFinished = DateTime.now().isAfter(devoirData.dateLimite);
      color = isFinished ? Colors.red : Colors.blue;
      texte = isFinished ? " [NON RENDU]" : " [PAS ENCORE RENDU]";
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/devoirs-detail', arguments: devoirData);
      },
      child: ListTile(
          title: Text(
              "Devoir à rendre avant le "
              "${DateFormat.yMMMMd('fr_FR').add_Hm().format(devoirData.dateLimite)}"
              "$texte",
              style: TextStyle(color: color)),
          subtitle: Text(
            devoirData.devoirInfos.contenu,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
    );
  }
}
