import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsElement extends StatefulWidget {
  final String type ;
  final String content ;
  const SettingsElement({Key key , this.type, this.content}) : super(key: key);

  @override
  _SettingsElementState createState() => _SettingsElementState();
}

class _SettingsElementState extends State<SettingsElement> {
  String type ;
  String content ;
  TextEditingController _inputController ;
  @override
  void initState() {
    type = widget.type ;
    content = widget.content ;
    super.initState();
    _inputController = new TextEditingController(text: content);
  }
  @override
  Widget build(BuildContext context) {

    return  Column(

        children: [
           Row(
             children: [

               Expanded(
                 flex: 3,
                 child: TextField(
                   controller: _inputController,
                   decoration: InputDecoration(

labelText: type
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
