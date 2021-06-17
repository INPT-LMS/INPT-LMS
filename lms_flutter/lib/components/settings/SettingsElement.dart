import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsElement extends StatefulWidget {
  final String type ;
  const SettingsElement({Key key , this.type}) : super(key: key);

  @override
  _SettingsElementState createState() => _SettingsElementState();
}

class _SettingsElementState extends State<SettingsElement> {
  String type ;
  @override
  void initState() {
    type = widget.type ;
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return  Column(

        children: [
           Row(
             children: [
               Expanded(
                 flex: 1,
                 child : Text(
                     type
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
