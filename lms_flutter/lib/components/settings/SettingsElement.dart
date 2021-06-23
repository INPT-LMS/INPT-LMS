import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/screens/utils.dart';

class SettingsElement extends StatefulWidget {
  final String type ;
  final String content ;
  final Function changeInfos ;
  const SettingsElement({Key key , this.type, this.content, this.changeInfos}) : super(key: key);

  @override
  _SettingsElementState createState() => _SettingsElementState();
}

class _SettingsElementState extends State<SettingsElement> {
  String type ;
  String content ;
  Function changeInfos ;
  TextEditingController _inputController ;
  @override
  void initState() {
    type = widget.type ;
    content = widget.content ;
    changeInfos = widget.changeInfos;
    super.initState();
    _inputController = new TextEditingController(text: content,);
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
                   onChanged: (_){
                     changeInfos(type,_inputController.text);

                   },
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
