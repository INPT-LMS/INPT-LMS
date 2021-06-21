import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/profile/ProfilePic.dart';
import 'package:lms_flutter/components/settings/ProfilePic.dart';
import 'package:lms_flutter/components/settings/SettingsElement.dart';
import 'package:lms_flutter/components/settings/passwordEdit.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/services/settings_service.dart';

class SettingsComp extends StatefulWidget {
  const SettingsComp({Key key}) : super(key: key);

  @override
  _SettingsCompState createState() => _SettingsCompState();
}

class _SettingsCompState extends State<SettingsComp> {
  SettingsService settingsService;
  var data ;
  @override
  void initState() {
    super.initState();
    settingsService = getIt.get<SettingsService>();


  }
  @override
  Widget build(BuildContext context) {
    data = settingsService.getUserLoggedInfos();

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
                         SettingsElement(type : "nom", content : data.nom),
                         SettingsElement(type : "Langue" , content : data.langue),

                       ],
                     ),

                    ],
                  ),
                  ExpansionTile(
                    title: Text("Security"),
                    children: [
                      PasswordEditElement(),

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

                      onPressed: () {
                        showSnackbar(context, data.email);
                        },
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
