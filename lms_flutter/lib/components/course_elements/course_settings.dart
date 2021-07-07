import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/model/course/member.dart';
import 'package:lms_flutter/screens/utils.dart';

class SettingsWidget extends StatelessWidget {
  final List<Member> members ;
  const SettingsWidget( this.members, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.topRight,
        child: PopupMenuButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              child: ListTile(
                title: Text(
                  'Contact professor',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(
                title: Text('Share', textAlign: TextAlign.center),
              ),
            ),
             PopupMenuItem(

                child: ListTile(
                  onTap: (){

                    return showDialog(context: context, builder: (context){
                      return Dialog(child: Column(children: [for (int i = 0 ; i < members.length ; i++ )  Text(members[i].memberID.toString())]));
                    });
                  },
                  title: Text('Members', textAlign: TextAlign.center),
                ),
            ),
            const PopupMenuItem(
              child: ListTile(
                title: Text('Edit course', textAlign: TextAlign.center),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(
                title: Text(
                  'Quit',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
