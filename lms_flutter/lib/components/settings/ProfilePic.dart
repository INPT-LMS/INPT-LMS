import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilPicEdit extends StatefulWidget {
  const ProfilPicEdit({Key key}) : super(key: key);

  @override
  _ProfilPicEditState createState() => _ProfilPicEditState();
}

class _ProfilPicEditState extends State<ProfilPicEdit> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3)),
        child: CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage("images/pic.jpg"),
        ),
      ),
        Positioned(
          bottom: 14.0,
          right: 14.0,
          child:  Icon(Icons.edit, color: Colors.white,size: 36,)
        ),
      ]
    );
  }
}
