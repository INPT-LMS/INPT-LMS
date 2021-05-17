import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
import 'package:lms_flutter/components/consts/message_position.dart';
import 'package:lms_flutter/model/messages/message_data.dart';

class Message extends StatelessWidget {
  MessagePosition position;
  MessageData data;
  Message(this.data, {Key key, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isEmetteur = position == MessagePosition.emetteur;
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
              child: Text(DateFormat.jm().format(data.date),
                  style: TextStyle(color: Colors.grey)),
              alignment: Alignment.bottomRight,
            )
          ],
        ),
      ),
    );
  }
}
