import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/profile/ProfilePic.dart';
import 'package:lms_flutter/components/settings/ProfilePic.dart';
import 'package:lms_flutter/components/settings/SettingsElement.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';

class SettingsComp extends StatefulWidget {
  const SettingsComp({Key key}) : super(key: key);

  @override
  _SettingsCompState createState() => _SettingsCompState();
}

class _SettingsCompState extends State<SettingsComp> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 24
              ),
                child: ProfilPicEdit()),
          Container(
            padding: EdgeInsets.all(12),
            child: Text("Hello, My name",
            style: TextStyle(
              fontSize: 24
            ),),
          ),
            Container(

              padding: EdgeInsets.all(24),
              child: Column(

                children: [
                  ExpansionTile(
                    title: Text("General informations"),
                    children: [
                     ListView(
                       shrinkWrap: true,
                       children: [
                         for(var i = 0 ; i < 3 ; i++)  SettingsElement(type : i.toString()  )
                       ],
                     ),

                    ],
                  ),
                  ExpansionTile(
                    title: Text("Security"),
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: [
                          for(var i = 0 ; i < 3 ; i++)  SettingsElement(type : i.toString()  )
                        ],
                      ),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 48,
                    ),
                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                bottomLeft: Radius.circular(24))),
                        primary: Color(0xff0275B1), // background
                        onPrimary: Colors.white, // foreground
                      ),

                      onPressed: () {  },
                      child: Text(
                        "Mettre a jour",
                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
