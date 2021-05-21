import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsElement extends StatefulWidget {
  const SettingsElement({Key key}) : super(key: key);

  @override
  _SettingsElementState createState() => _SettingsElementState();
}

class _SettingsElementState extends State<SettingsElement> {

  @override
  Widget build(BuildContext context) {
    return  Column(

        children: [
           Row(
             children: [
               Expanded(
                 flex: 1,
                 child : Text(
                     "Email :"
                 ),
               ),
               Expanded(
                 flex: 3,
                 child: TextField(
                   keyboardType: TextInputType.emailAddress,
                   decoration: InputDecoration(
                     hintText: "test@gmail.com",
                   ),
                    style: TextStyle(

                    ),
                  ),
               ),
             ],
           ),


        ],
      );

  }
}
