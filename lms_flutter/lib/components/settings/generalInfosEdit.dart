import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/services/settings_service.dart';

import 'SettingsElement.dart';

class GeneralInfosEdit extends StatefulWidget {
  const GeneralInfosEdit({Key key}) : super(key: key);

  @override
  _GeneralInfosEditState createState() => _GeneralInfosEditState();
}

class _GeneralInfosEditState extends State<GeneralInfosEdit> {
  SettingsService settingsService;
  var data;
  var UpdatedData;
  void changeInfos(var type, var value) {
    switch (type) {
      case "nom":
        setState(() {
          UpdatedData.nom = value;
        });
        break;
      case "email":
        setState(() {
          UpdatedData.email = value;
        });
        break;
      case "langue":
        setState(() {
          UpdatedData.langue = value;
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    settingsService = getIt.get<SettingsService>();
    data = settingsService.getUserLoggedInfos();
    UpdatedData = data;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SettingsElement(
          type: "nom",
          content: data.nom,
          changeInfos: changeInfos,
        ),
        SettingsElement(
            type: "email", content: data.email, changeInfos: changeInfos),
        SettingsElement(
            type: "langue", content: data.langue, changeInfos: changeInfos),
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
              settingsService.updateUser(UpdatedData, data.id).then((value) {
                showSnackbar(context, "Updated succesfully");
              }).onError((error, stackTrace) => showSnackbar(context, "An error accured"));
              setState(() {
                data = settingsService.getUserLoggedInfos();
              });
            },
            child: Text(
              "Mettre a jour",
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
