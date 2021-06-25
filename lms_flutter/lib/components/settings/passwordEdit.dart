import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/model/settings/password_change_form.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/services/settings_service.dart';

class PasswordEditElement extends StatefulWidget {

  const PasswordEditElement({Key key}) : super(key: key);

  @override
  _PasswordEditElementState createState() => _PasswordEditElementState();
}

class _PasswordEditElementState extends State<PasswordEditElement> {
  TextEditingController _oldPasswordController ;
  TextEditingController _newPasswordController ;
  TextEditingController _newPasswordController2 ;
  SettingsService settingsService ;
  CompteService compteService ;
  @override
  void initState() {
    settingsService = getIt.get<SettingsService>();
    compteService = getIt.get<CompteService>();
    _oldPasswordController = new TextEditingController();
    _newPasswordController = new TextEditingController();
    _newPasswordController2 = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Row(
              children: [

                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _oldPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(

                        labelText: "Ancient mot de passe"
                    ),

                  ),
                ),
              ],
            ),
            Row(
              children: [

                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Nouveau mot de passe"
                    ),

                  ),
                ),
              ],
            ),
            Row(
              children: [

                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _newPasswordController2,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirmer le mot de passe"

                    ),

                  ),
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

                onPressed: () {
                 if(_newPasswordController.value.text != _newPasswordController2.value.text){
                   showSnackbar(context, "les entrees des nouveaux mots de passes ne sont pas identiques");
                   _newPasswordController.clear();
                   _newPasswordController2.clear();
                 }
                 else{
                   var passwordForm = new PasswordEditForm(
                       _oldPasswordController.value.text,
                       _newPasswordController.value.text );
                   int id = compteService.getUserLoggedInfos().id;
                   settingsService.changePassword(passwordForm,id);
                 }



                },
                child: Text(
                  "Mettre a jour",
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 24),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
