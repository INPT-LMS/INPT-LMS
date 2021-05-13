import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
class ConfirmPasswordField extends StatelessWidget {
  var passwordController;
  var controller;
  ConfirmPasswordField(TextEditingController this.controller,
      TextEditingController this.passwordController,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CustomColors.LIGHT_BLUE_1,
        margin: EdgeInsets.all(20),
        child: TextFormField(obscureText: true,
          controller: controller,
          validator: (value) => (value != passwordController.text)
              ? "Les mots de passe sont différents" : null,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Confirmez votre mot de passe'),
        )
    );
  }
}
