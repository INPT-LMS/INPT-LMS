import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordEditElement extends StatefulWidget {

  const PasswordEditElement({Key key}) : super(key: key);

  @override
  _PasswordEditElementState createState() => _PasswordEditElementState();
}

class _PasswordEditElementState extends State<PasswordEditElement> {
  TextEditingController _oldPasswordController ;
  TextEditingController _newPasswordController ;
  TextEditingController _newPasswordController2 ;
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
                    controller: _newPasswordController2,
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
                    controller: _newPasswordController2,
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
                    decoration: InputDecoration(
                      labelText: "Confirmer le mot de passe"
                    ),

                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
