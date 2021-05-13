import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
class PasswordField extends StatelessWidget {
  var controller;
  PasswordField(TextEditingController this.controller,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CustomColors.LIGHT_BLUE_1,
        margin: EdgeInsets.all(20),
        child: TextFormField(obscureText: true,
          controller: controller,
          validator: (value) => (value == null || value.length < 6)
        ? "Mot de passe trop court" : null,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Entrez votre mot de passe'),
        )
    );
  }
}
