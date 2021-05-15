import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.topRight,

        child: PopupMenuButton(

          icon: Icon(Icons.settings,color: Colors.white,),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              child: ListTile(

                title: Text('Contact professor'  , textAlign: TextAlign.center,),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(

                title: Text('Share' , textAlign: TextAlign.center),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(

                title: Text('Members' , textAlign: TextAlign.center),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(

                title: Text('Edit course' , textAlign: TextAlign.center),
              ),
            ),
             const PopupMenuItem(
               child: ListTile(

                 title: Text('Quit' , textAlign: TextAlign.center, style: TextStyle(
                   color: Colors.red
                 ),),
    ),
    ),
          ],
        ),
      ),
    );
  }
}
