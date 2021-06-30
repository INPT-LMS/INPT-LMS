import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/settings/ProfilePic.dart';
import 'package:lms_flutter/components/settings/generalInfosEdit.dart';
import 'package:lms_flutter/components/settings/passwordEdit.dart';
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
                padding: EdgeInsets.only(top: 24), child: ProfilPicEdit()),
            Container(
              padding: EdgeInsets.all(12),
              child: Text(
                "Hello, My name",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text("General informations"),
                    children: [GeneralInfosEdit()],
                  ),
                  ExpansionTile(
                    title: Text("Security"),
                    children: [
                      PasswordEditElement(),
                    ],
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
