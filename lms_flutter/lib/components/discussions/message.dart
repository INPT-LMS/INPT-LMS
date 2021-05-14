import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
import 'package:lms_flutter/components/consts/message_position.dart';

class Message extends StatelessWidget {
  MessagePosition position;
  Message(this.position,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isEmetteur = position == MessagePosition.emetteur;
    return Align(
      alignment: isEmetteur ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: new BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 2),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isEmetteur ? CustomColors.LIGHT_BLUE_2 :  CustomColors.DARK_BLUE,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Text("consectetur adipiscing elit consectetur "
                "adipiscing elit",style: TextStyle(color: isEmetteur ?
            Colors.black : Colors.white)),
            Align(
              child: Text("15:11",style: TextStyle(color: Colors.grey)),
              alignment: Alignment.bottomRight,
            )
          ],
        ),
      ),
    );
  }
}
