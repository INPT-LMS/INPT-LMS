import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
import 'package:lms_flutter/model/discussion/message_data.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:provider/provider.dart';

class Message extends StatelessWidget {
  final MessageData data;
  Message(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var infos = Provider.of<InfosModel>(context, listen: false).userInfos;
    var isEmetteur = infos.id == data.idEmetteur;
    return Align(
      alignment: isEmetteur ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints:
            new BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color:
                isEmetteur ? CustomColors.LIGHT_BLUE_2 : CustomColors.DARK_BLUE,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Text(data.contenu,
                style:
                    TextStyle(color: isEmetteur ? Colors.black : Colors.white)),
            Align(
              child: Text(DateFormat.yMd("fr_FR").add_Hm().format(data.date),
                  style: TextStyle(color: Colors.grey)),
              alignment: Alignment.bottomRight,
            )
          ],
        ),
      ),
    );
  }
}
